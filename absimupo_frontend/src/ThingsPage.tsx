import React from "react";
import { graphql, useLazyLoadQuery, usePaginationFragment } from "react-relay";
import { SafeAreaView, StatusBar, StyleSheet } from "react-native";

import ThingsList from "./ThingsList";
import CreateThingForm from "./CreateThingForm";
import ListThingsFragment from "./ListThingsFragment";
import type { ListThingsFragment$key } from "./__generated__/ListThingsFragment.graphql";
import { ThingsPageQuery as ThingsPageQueryType } from "./__generated__/ThingsPageQuery.graphql";

const pageSize = 2;

const ThingsPage = () => {
  const queryData: ListThingsFragment$key =
    useLazyLoadQuery<ThingsPageQueryType>(
      graphql`
        query ThingsPageQuery($first: Int!, $after: String) {
          ...ListThingsFragment @arguments(first: $first, after: $after)
        }
      `,
      { first: pageSize }
    );

  const conn = usePaginationFragment(ListThingsFragment, queryData);
  const connectionID = conn?.data?.listThings?.__id;

  return (
    <SafeAreaView style={styles.container}>
      <CreateThingForm />
      {connectionID && <ThingsList pageSize={pageSize} conn={conn} />}
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: StatusBar.currentHeight || 0,
  },
});

export default ThingsPage;
