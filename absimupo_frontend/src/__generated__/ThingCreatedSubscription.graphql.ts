/* tslint:disable */
/* eslint-disable */
// @ts-nocheck

import { ConcreteRequest } from "relay-runtime";
export type ThingCreatedSubscriptionVariables = {};
export type ThingCreatedSubscriptionResponse = {
  readonly thingCreated: {
    readonly edges: ReadonlyArray<{
      readonly cursor: string | null;
      readonly node: {
        readonly id: string;
        readonly name: string | null;
        readonly imageUrlLogo: string | null;
      } | null;
    } | null> | null;
  } | null;
};
export type ThingCreatedSubscription = {
  readonly response: ThingCreatedSubscriptionResponse;
  readonly variables: ThingCreatedSubscriptionVariables;
};

/*
subscription ThingCreatedSubscription {
  thingCreated {
    edges {
      cursor
      node {
        id
        name
        imageUrlLogo
      }
    }
  }
}
*/

const node: ConcreteRequest = (function () {
  var v0 = [
    {
      alias: null,
      args: null,
      concreteType: "ThingConnection",
      kind: "LinkedField",
      name: "thingCreated",
      plural: false,
      selections: [
        {
          alias: null,
          args: null,
          concreteType: "ThingEdge",
          kind: "LinkedField",
          name: "edges",
          plural: true,
          selections: [
            {
              alias: null,
              args: null,
              kind: "ScalarField",
              name: "cursor",
              storageKey: null,
            },
            {
              alias: null,
              args: null,
              concreteType: "Thing",
              kind: "LinkedField",
              name: "node",
              plural: false,
              selections: [
                {
                  alias: null,
                  args: null,
                  kind: "ScalarField",
                  name: "id",
                  storageKey: null,
                },
                {
                  alias: null,
                  args: null,
                  kind: "ScalarField",
                  name: "name",
                  storageKey: null,
                },
                {
                  alias: null,
                  args: null,
                  kind: "ScalarField",
                  name: "imageUrlLogo",
                  storageKey: null,
                },
              ],
              storageKey: null,
            },
          ],
          storageKey: null,
        },
      ],
      storageKey: null,
    },
  ];
  return {
    fragment: {
      argumentDefinitions: [],
      kind: "Fragment",
      metadata: null,
      name: "ThingCreatedSubscription",
      selections: v0 /*: any*/,
      type: "RootSubscriptionType",
      abstractKey: null,
    },
    kind: "Request",
    operation: {
      argumentDefinitions: [],
      kind: "Operation",
      name: "ThingCreatedSubscription",
      selections: v0 /*: any*/,
    },
    params: {
      cacheID: "2d3e86015fc88c2fdd47dee9fe6685ac",
      id: null,
      metadata: {},
      name: "ThingCreatedSubscription",
      operationKind: "subscription",
      text: "subscription ThingCreatedSubscription {\n  thingCreated {\n    edges {\n      cursor\n      node {\n        id\n        name\n        imageUrlLogo\n      }\n    }\n  }\n}\n",
    },
  };
})();
(node as any).hash = "ff7daeef5fd204f67a878d82c66a71e8";
export default node;
