import React, { useEffect, useState } from "react";
import {
  Environment,
  Network,
  Observable,
  RecordSource,
  Store,
} from "relay-runtime";
import Constants from 'expo-constants';
import * as AbsintheSocket from "@absinthe/socket";
import { createSubscriber } from "@absinthe/socket-relay";
import { RelayEnvironmentProvider } from "react-relay/hooks";
import { useAbsintheSocket } from "../contexts/AbsintheSocketContext";
import { generateForm } from "../utils/uploadable-utils";

const { httpUrl } = Constants.manifest.extra;

function createFetchQuery(absintheSocket, onError) {
  return function fetchQuery(operation, variables, _cacheConfig, uploadables) {
    if (uploadables) {
      return new Promise(async (resolve, reject) => {
        if (!window.FormData) {
          throw new Error("Uploading files without `FormData` not supported.");
        }
        const request = {
          method: "POST",
          headers: {},
        };

        const formData = await generateForm(operation, variables, uploadables);
        request.body = formData;
        return (
          fetch(httpUrl, request)
            .then((response) => {
              // if (response.status === 200) {
              resolve(response.json());
              // }

              // HTTP errors
              // TODO: NOT sure what to do here yet
              // return response.json();
              // resolve(response.json());
            })
            // .then(() => resolve())
            .catch((error) => {
              reject(error);
            })
        );
      });
    } else {
      return new Promise((resolve, reject) => {
        return AbsintheSocket.observe(
          absintheSocket,
          AbsintheSocket.send(absintheSocket, {
            operation: operation.text,
            variables: variables,
          }),
          {
            onError: onError,
            onAbort: reject,
            onResult: resolve,
          }
        );
      });
    }
  };
}

const RelayEnvironment = ({ children }) => {
  const { socket } = useAbsintheSocket();
  const createEnvironment = (socket) => {
    const legacySubscribe = createSubscriber(socket);
    const subscribe = (request, variables, cacheConfig) => {
      return Observable.create((sink) => {
        legacySubscribe(request, variables, cacheConfig, {
          onNext: sink.next,
          onError: sink.error,
          onCompleted: sink.complete,
        });
      });
    };
    return new Environment({
      network: Network.create(createFetchQuery(socket), subscribe),
      store: new Store(new RecordSource()),
    });
  };
  const initialEnvironment = createEnvironment(socket);
  const [environment, setEnvironment] = useState(initialEnvironment);
  useEffect(() => {
    const newEnvironment = createEnvironment(socket);
    setEnvironment(newEnvironment);
  }, [socket]);
  return (
    <RelayEnvironmentProvider environment={environment}>
      {children}
    </RelayEnvironmentProvider>
  );
};

export default RelayEnvironment;
