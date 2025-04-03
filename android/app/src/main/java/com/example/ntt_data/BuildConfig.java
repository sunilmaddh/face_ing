package com.example.ntt_data;

public final class BuildConfig {

        public static final boolean DEBUG;

    static {
        Boolean.parseBoolean("true");
        DEBUG = true;
    }

    public static final String APPLICATION_ID = "ai.nuralogix.nura.sample";
        public static final String BUILD_TYPE = "debug";
        public static final int VERSION_CODE = 1;
        public static final String VERSION_NAME = "2.4.8";
        // Field from default config.
        public static final String DFX_LICENSE_KEY = "e9d79028-0884-4247-8aab-91f77020947a";
        // Field from default config.
        public static final String DFX_REST_URL = "https://api.deepaffex.ai";
        // Field from default config.
        public static final String DFX_STUDY_ID = "59f95685-8949-4ee0-a0e8-28b524882dbc";
        // Field from default config.
        public static final String DFX_WS_URL = "wss://api.deepaffex.ai";
    }


