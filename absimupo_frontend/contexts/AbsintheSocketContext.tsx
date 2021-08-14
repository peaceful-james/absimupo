import React, {
  createContext,
  ReactNode,
  useContext,
  useState,
  useEffect,
} from "react";
import { AbsintheSocket, create } from "@absinthe/socket";
import Constants from "expo-constants";
import { Socket as PhoenixSocket } from "phoenix";

const wsUrl = Constants.manifest?.extra?.wsUrl;

// https://github.com/absinthe-graphql/absinthe-socket/issues/44

const initialSocket = create(new PhoenixSocket(wsUrl));

const AbsintheSocketContext = createContext({ socket: initialSocket });

export const useAbsintheSocket = () => useContext(AbsintheSocketContext);

type Props = { children: ReactNode };

export const AbsintheSocketProvider = ({ children }: Props) => {
  const [socket, setSocket] = useState<AbsintheSocket>(initialSocket);

  useEffect(() => {
    setSocket(create(new PhoenixSocket(wsUrl)));
  }, []);

  return (
    <AbsintheSocketContext.Provider value={{ socket }}>
      {children}
    </AbsintheSocketContext.Provider>
  );
};
