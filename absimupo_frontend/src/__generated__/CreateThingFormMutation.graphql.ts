/* tslint:disable */
/* eslint-disable */
// @ts-nocheck

import { ConcreteRequest } from "relay-runtime";
export type ThingInput = {
  logo?: UploadableMap | null;
  name: string;
};
export type CreateThingFormMutationVariables = {
  input: ThingInput;
};
export type CreateThingFormMutationResponse = {
  readonly thing: {
    readonly errors: ReadonlyArray<{
      readonly key: string;
      readonly message: string;
      readonly statusCode: number | null;
    } | null> | null;
    readonly thing: {
      readonly edges: ReadonlyArray<{
        readonly cursor: string | null;
        readonly node: {
          readonly id: string;
          readonly name: string | null;
          readonly imageUrlLogo: string | null;
        } | null;
      } | null> | null;
    } | null;
  } | null;
};
export type CreateThingFormMutation = {
  readonly response: CreateThingFormMutationResponse;
  readonly variables: CreateThingFormMutationVariables;
};

/*
mutation CreateThingFormMutation(
  $input: ThingInput!
) {
  thing: createThing(input: $input) {
    errors {
      key
      message
      statusCode
    }
    thing {
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
}
*/

const node: ConcreteRequest = (function () {
  var v0 = [
      {
        defaultValue: null,
        kind: "LocalArgument",
        name: "input",
      },
    ],
    v1 = [
      {
        alias: "thing",
        args: [
          {
            kind: "Variable",
            name: "input",
            variableName: "input",
          },
        ],
        concreteType: "ThingResult",
        kind: "LinkedField",
        name: "createThing",
        plural: false,
        selections: [
          {
            alias: null,
            args: null,
            concreteType: "InputError",
            kind: "LinkedField",
            name: "errors",
            plural: true,
            selections: [
              {
                alias: null,
                args: null,
                kind: "ScalarField",
                name: "key",
                storageKey: null,
              },
              {
                alias: null,
                args: null,
                kind: "ScalarField",
                name: "message",
                storageKey: null,
              },
              {
                alias: null,
                args: null,
                kind: "ScalarField",
                name: "statusCode",
                storageKey: null,
              },
            ],
            storageKey: null,
          },
          {
            alias: null,
            args: null,
            concreteType: "ThingConnection",
            kind: "LinkedField",
            name: "thing",
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
        ],
        storageKey: null,
      },
    ];
  return {
    fragment: {
      argumentDefinitions: v0 /*: any*/,
      kind: "Fragment",
      metadata: null,
      name: "CreateThingFormMutation",
      selections: v1 /*: any*/,
      type: "RootMutationType",
      abstractKey: null,
    },
    kind: "Request",
    operation: {
      argumentDefinitions: v0 /*: any*/,
      kind: "Operation",
      name: "CreateThingFormMutation",
      selections: v1 /*: any*/,
    },
    params: {
      cacheID: "92f5868ee44eec387f60fe2e0be7a7fc",
      id: null,
      metadata: {},
      name: "CreateThingFormMutation",
      operationKind: "mutation",
      text: "mutation CreateThingFormMutation(\n  $input: ThingInput!\n) {\n  thing: createThing(input: $input) {\n    errors {\n      key\n      message\n      statusCode\n    }\n    thing {\n      edges {\n        cursor\n        node {\n          id\n          name\n          imageUrlLogo\n        }\n      }\n    }\n  }\n}\n",
    },
  };
})();
(node as any).hash = "72a40a3382349ccd8f2ae1dc3f7bc752";
export default node;
