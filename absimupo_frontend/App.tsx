import { StatusBar } from "expo-status-bar";
import React, { Suspense } from "react";
import { SafeAreaProvider } from "react-native-safe-area-context";
import { AbsintheSocketProvider } from "./contexts/AbsintheSocketContext";
import { ThemeProvider } from "./contexts/ThemeContext";
import Loading from "./src/Loading";
import RelayEnvironment from "./src/RelayEnvironment";
import RootContainer from "./src/RootContainer";
import ThingsPage from "./src/ThingsPage";

export default function App() {
  return (
    <SafeAreaProvider>
      <AbsintheSocketProvider>
        <RelayEnvironment>
          <ThemeProvider>
            <RootContainer>
              <Suspense fallback={<Loading />}>
                <ThingsPage />
              </Suspense>
              <StatusBar style="auto" />
            </RootContainer>
          </ThemeProvider>
        </RelayEnvironment>
      </AbsintheSocketProvider>
    </SafeAreaProvider>
  );
}
