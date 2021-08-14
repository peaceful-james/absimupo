import React, { useState } from "react";
import type { ReactElement } from "react";
import { useSubscription } from "react-relay";
import {
  FlatList,
  Image,
  ListRenderItem,
  Pressable,
  StyleSheet,
  Text,
  View,
} from "react-native";
import ThingCreatedSubscription from "./ThingCreatedSubscription";
import { ConnectionHandler, RecordSourceSelectorProxy } from "relay-runtime";
import { useTheme } from "../contexts/ThemeContext";

type Props = {
  conn: any;
  pageSize: number;
};

const ThingsList = (props: Props) => {
  const { conn, pageSize } = props;
  const { data, loadNext, hasNext } = conn;
  const connectionID = conn?.data?.listThings?.__id;
  const { colors } = useTheme();
  const [logo, setLogo] = useState<string | undefined>(undefined);

  const updater = (store: RecordSourceSelectorProxy<any>) => {
    const connectionRecord = store.get(connectionID);
    const payload = store.getRootField("thingCreated");
    if (payload && connectionRecord) {
      const payloadEdges = payload.getLinkedRecords("edges");
      if (payloadEdges) {
        const serverEdge = payloadEdges[0];
        const newEdge = ConnectionHandler.buildConnectionEdge(
          store,
          connectionRecord,
          serverEdge
        );
        newEdge && ConnectionHandler.insertEdgeAfter(connectionRecord, newEdge);
      }
    }
  };

  useSubscription({
    variables: {},
    subscription: ThingCreatedSubscription,
    updater,
  });

  const styles = StyleSheet.create({
    root: {
      flexDirection: "row",
      justifyContent: "center",
      backgroundColor: colors.background,
    },
    header: {
      color: colors.text,
      fontSize: 26,
      marginBottom: 8,
    },
    text: {
      color: colors.text,
      fontSize: 10,
    },
    showThingLogoButton: {
      alignItems: "center",
      justifyContent: "center",
      paddingVertical: 12,
      paddingHorizontal: 32,
      borderRadius: 4,
      marginTop: 8,
      elevation: 3,
      color: "white",
      backgroundColor: colors.primary,
    },
    loadMoreButton: {
      alignItems: "center",
      justifyContent: "center",
      paddingVertical: 12,
      paddingHorizontal: 32,
      borderRadius: 4,
      marginTop: 16,
      elevation: 3,
      color: "white",
      backgroundColor: colors.backgroundTint,
    },
    item: {
      backgroundColor: "#f9c2ff",
      padding: 20,
      marginVertical: 8,
      marginHorizontal: 16,
    },
    title: {
      fontSize: 32,
    },
  });

  const Item: (edge: { name: string; imageUrlLogo: string }) => ReactElement =
    ({ name, imageUrlLogo }) => {
      return (
        <Pressable
          style={styles.showThingLogoButton}
          onPress={() => setLogo(imageUrlLogo)}
        >
          <Text style={styles.text}>{name}</Text>
        </Pressable>
      );
    };

  const renderItem: ListRenderItem<{
    cursor: string;
    node: { id: string; name: string; imageUrlLogo: string };
  }> = ({ item: edge }) => {
    const { name, imageUrlLogo } = edge.node;
    return <Item imageUrlLogo={imageUrlLogo} name={name} />;
    // {/* <Text style={styles.header}>Click on a thing to see its logo:</Text> */ }
  };

  return (
    <View style={styles.root}>
      <View>
        {data && data.listThings && data.listThings.edges && (
          <FlatList
            data={data.listThings.edges}
            renderItem={renderItem}
            keyExtractor={(edge) => {
              return edge.node.id;
            }}
          />
        )}
        {hasNext && (
          <Pressable
            style={styles.loadMoreButton}
            onPress={() => loadNext(pageSize)}
          >
            <Text style={styles.text}>Load More</Text>
          </Pressable>
        )}
      </View>
      <View>
        <Image source={{ uri: logo }} style={{ width: 200, height: 200 }} />
      </View>
    </View>
  );
};
export default ThingsList;
