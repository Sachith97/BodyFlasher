package com.sac.workoutservice.enums;

/**
 * @author Sachith Harshamal
 * @created 2023-03-15
 */
public enum Response {

    SUCCESS(Boolean.TRUE, 1, "Success"),
    FAILED(Boolean.FALSE, 2, "Failed with unhandled error"),
    NOT_FOUND(Boolean.FALSE, 3, "Can not find request details");

    private final boolean isOk;
    private final int responseCode;
    private final String responseMessage;

    Response(boolean isOk, int responseCode, String responseMessage) {
        this.isOk = isOk;
        this.responseCode = responseCode;
        this.responseMessage = responseMessage;
    }

    public boolean isOk() {
        return isOk;
    }

    public int getResponseCode() {
        return this.responseCode;
    }

    public String getResponseMessage() {
        return this.responseMessage;
    }
}
