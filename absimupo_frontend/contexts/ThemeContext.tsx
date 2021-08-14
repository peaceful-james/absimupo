import React, { createContext, ReactNode, useContext } from "react";
import { Appearance } from 'react-native';
import Colors from "../constants/Colors";

export const ThemeContext = createContext({ colors: Colors.light });

export const useTheme = () => useContext(ThemeContext);

type ThemeProviderProps = {
    children: ReactNode;
};

export const ThemeProvider = ({ children }: ThemeProviderProps) => {
    const colorScheme = Appearance.getColorScheme();
    const darkMode = colorScheme === 'dark'
    return (
        <ThemeContext.Provider
            value={{
                colors: darkMode ? Colors.dark : Colors.light,
            }}
        >
            {children}
        </ThemeContext.Provider>
    );
};
