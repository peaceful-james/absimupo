import { graphql } from "react-relay";

const ThingCreatedSubscription = graphql`
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
`;

export default ThingCreatedSubscription;
