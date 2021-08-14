/* tslint:disable */
/* eslint-disable */
// @ts-nocheck

import { ConcreteRequest } from "relay-runtime";
import { FragmentRefs } from "relay-runtime";
export type ThingsPageQueryVariables = {
  first: number;
  after?: string | null;
};
export type ThingsPageQueryResponse = {
  readonly " $fragmentRefs": FragmentRefs<"ListThingsFragment">;
};
export type ThingsPageQuery = {
  readonly response: ThingsPageQueryResponse;
  readonly variables: ThingsPageQueryVariables;
};

/*
query ThingsPageQuery(
  $first: Int!
  $after: String
) {
  ...ListThingsFragment_2HEEH6
}

fragment ListThingsFragment_2HEEH6 on RootQueryType {
  listThings(first: $first, after: $after) {
    pageInfo {
      hasNextPage
      hasPreviousPage
      endCursor
    }
    edges {
      cursor
      node {
        id
        name
        imageUrlLogo
        __typename
      }
    }
  }
}
*/

const node: ConcreteRequest = (function () {
  var v0 = {
      defaultValue: null,
      kind: "LocalArgument",
      name: "after",
    },
    v1 = {
      defaultValue: null,
      kind: "LocalArgument",
      name: "first",
    },
    v2 = [
      {
        kind: "Variable",
        name: "after",
        variableName: "after",
      },
      {
        kind: "Variable",
        name: "first",
        variableName: "first",
      },
    ];
  return {
    fragment: {
      argumentDefinitions: [v0 /*: any*/, v1 /*: any*/],
      kind: "Fragment",
      metadata: null,
      name: "ThingsPageQuery",
      selections: [
        {
          args: v2 /*: any*/,
          kind: "FragmentSpread",
          name: "ListThingsFragment",
        },
      ],
      type: "RootQueryType",
      abstractKey: null,
    },
    kind: "Request",
    operation: {
      argumentDefinitions: [v1 /*: any*/, v0 /*: any*/],
      kind: "Operation",
      name: "ThingsPageQuery",
      selections: [
        {
          alias: null,
          args: v2 /*: any*/,
          concreteType: "ThingConnection",
          kind: "LinkedField",
          name: "listThings",
          plural: false,
          selections: [
            {
              alias: null,
              args: null,
              concreteType: "PageInfo",
              kind: "LinkedField",
              name: "pageInfo",
              plural: false,
              selections: [
                {
                  alias: null,
                  args: null,
                  kind: "ScalarField",
                  name: "hasNextPage",
                  storageKey: null,
                },
                {
                  alias: null,
                  args: null,
                  kind: "ScalarField",
                  name: "hasPreviousPage",
                  storageKey: null,
                },
                {
                  alias: null,
                  args: null,
                  kind: "ScalarField",
                  name: "endCursor",
                  storageKey: null,
                },
              ],
              storageKey: null,
            },
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
                    {
                      alias: null,
                      args: null,
                      kind: "ScalarField",
                      name: "__typename",
                      storageKey: null,
                    },
                  ],
                  storageKey: null,
                },
              ],
              storageKey: null,
            },
            {
              kind: "ClientExtension",
              selections: [
                {
                  alias: null,
                  args: null,
                  kind: "ScalarField",
                  name: "__id",
                  storageKey: null,
                },
              ],
            },
          ],
          storageKey: null,
        },
        {
          alias: null,
          args: v2 /*: any*/,
          filters: null,
          handle: "connection",
          key: "ListThingsFragment_listThings",
          kind: "LinkedHandle",
          name: "listThings",
        },
      ],
    },
    params: {
      cacheID: "9f1975f88367cc1a92a9474d6c8a6622",
      id: null,
      metadata: {},
      name: "ThingsPageQuery",
      operationKind: "query",
      text: "query ThingsPageQuery(\n  $first: Int!\n  $after: String\n) {\n  ...ListThingsFragment_2HEEH6\n}\n\nfragment ListThingsFragment_2HEEH6 on RootQueryType {\n  listThings(first: $first, after: $after) {\n    pageInfo {\n      hasNextPage\n      hasPreviousPage\n      endCursor\n    }\n    edges {\n      cursor\n      node {\n        id\n        name\n        imageUrlLogo\n        __typename\n      }\n    }\n  }\n}\n",
    },
  };
})();
(node as any).hash = "09f060fb63f832714937984fb444a61f";
export default node;
