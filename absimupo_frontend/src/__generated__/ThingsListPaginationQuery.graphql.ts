/* tslint:disable */
/* eslint-disable */
// @ts-nocheck

import { ConcreteRequest } from "relay-runtime";
import { FragmentRefs } from "relay-runtime";
export type ThingsListPaginationQueryVariables = {
  after?: string | null;
  first?: number | null;
};
export type ThingsListPaginationQueryResponse = {
  readonly " $fragmentRefs": FragmentRefs<"ListThingsFragment">;
};
export type ThingsListPaginationQuery = {
  readonly response: ThingsListPaginationQueryResponse;
  readonly variables: ThingsListPaginationQueryVariables;
};

/*
query ThingsListPaginationQuery(
  $after: String
  $first: Int
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
  var v0 = [
      {
        defaultValue: null,
        kind: "LocalArgument",
        name: "after",
      },
      {
        defaultValue: null,
        kind: "LocalArgument",
        name: "first",
      },
    ],
    v1 = [
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
      argumentDefinitions: v0 /*: any*/,
      kind: "Fragment",
      metadata: null,
      name: "ThingsListPaginationQuery",
      selections: [
        {
          args: v1 /*: any*/,
          kind: "FragmentSpread",
          name: "ListThingsFragment",
        },
      ],
      type: "RootQueryType",
      abstractKey: null,
    },
    kind: "Request",
    operation: {
      argumentDefinitions: v0 /*: any*/,
      kind: "Operation",
      name: "ThingsListPaginationQuery",
      selections: [
        {
          alias: null,
          args: v1 /*: any*/,
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
          args: v1 /*: any*/,
          filters: null,
          handle: "connection",
          key: "ListThingsFragment_listThings",
          kind: "LinkedHandle",
          name: "listThings",
        },
      ],
    },
    params: {
      cacheID: "a760b77d291ac92059cdd0d6be3face1",
      id: null,
      metadata: {},
      name: "ThingsListPaginationQuery",
      operationKind: "query",
      text: "query ThingsListPaginationQuery(\n  $after: String\n  $first: Int\n) {\n  ...ListThingsFragment_2HEEH6\n}\n\nfragment ListThingsFragment_2HEEH6 on RootQueryType {\n  listThings(first: $first, after: $after) {\n    pageInfo {\n      hasNextPage\n      hasPreviousPage\n      endCursor\n    }\n    edges {\n      cursor\n      node {\n        id\n        name\n        imageUrlLogo\n        __typename\n      }\n    }\n  }\n}\n",
    },
  };
})();
(node as any).hash = "6e1d67aef88d6ef38d2883ea9a21e87c";
export default node;
