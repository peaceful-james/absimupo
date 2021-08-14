import { graphql } from "react-relay";

const ListThingsFragment = graphql`
  fragment ListThingsFragment on RootQueryType
  @argumentDefinitions(
    first: { type: "Int" }
    after: { type: "String", defaultValue: null }
  )
  @refetchable(queryName: "ThingsListPaginationQuery") {
    listThings(first: $first, after: $after)
      @connection(key: "ListThingsFragment_listThings") {
      __id
      pageInfo {
        hasNextPage
        hasPreviousPage
      }
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
`;

export default ListThingsFragment;
