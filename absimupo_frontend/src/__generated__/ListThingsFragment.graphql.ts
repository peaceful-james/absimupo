/* tslint:disable */
/* eslint-disable */
// @ts-nocheck

import { ReaderFragment } from "relay-runtime";
import { FragmentRefs } from "relay-runtime";
export type ListThingsFragment = {
  readonly listThings: {
    readonly __id: string;
    readonly pageInfo: {
      readonly hasNextPage: boolean;
      readonly hasPreviousPage: boolean;
    };
    readonly edges: ReadonlyArray<{
      readonly cursor: string | null;
      readonly node: {
        readonly id: string;
        readonly name: string | null;
        readonly imageUrlLogo: string | null;
      } | null;
    } | null> | null;
  } | null;
  readonly " $refType": "ListThingsFragment";
};
export type ListThingsFragment$data = ListThingsFragment;
export type ListThingsFragment$key = {
  readonly " $data"?: ListThingsFragment$data;
  readonly " $fragmentRefs": FragmentRefs<"ListThingsFragment">;
};

const node: ReaderFragment = (function () {
  var v0 = ["listThings"];
  return {
    argumentDefinitions: [
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
    kind: "Fragment",
    metadata: {
      connection: [
        {
          count: "first",
          cursor: "after",
          direction: "forward",
          path: v0 /*: any*/,
        },
      ],
      refetch: {
        connection: {
          forward: {
            count: "first",
            cursor: "after",
          },
          backward: null,
          path: v0 /*: any*/,
        },
        fragmentPathInResult: [],
        operation: require("./ThingsListPaginationQuery.graphql.ts"),
      },
    },
    name: "ListThingsFragment",
    selections: [
      {
        alias: "listThings",
        args: null,
        concreteType: "ThingConnection",
        kind: "LinkedField",
        name: "__ListThingsFragment_listThings_connection",
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
    ],
    type: "RootQueryType",
    abstractKey: null,
  };
})();
(node as any).hash = "6e1d67aef88d6ef38d2883ea9a21e87c";
export default node;
