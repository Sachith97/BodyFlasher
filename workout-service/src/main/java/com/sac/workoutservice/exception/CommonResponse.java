package com.sac.workoutservice.exception;

import com.sac.workoutservice.enums.Response;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.RequiredArgsConstructor;

/**
 * @author Sachith Harshamal
 * @created 2023-03-15
 */
@Data
@AllArgsConstructor
@RequiredArgsConstructor
@Builder
public class CommonResponse {

    private boolean isOk;
    private int responseCode;
    private String responseMessage;
    private Object responseObject;

    public CommonResponse(Response response) {
        this.isOk = response.isOk();
        this.responseCode = response.getResponseCode();
        this.responseMessage = response.getResponseMessage();
    }

    public CommonResponse(Response response, Object responseObject) {
        this.isOk = response.isOk();
        this.responseCode = response.getResponseCode();
        this.responseMessage = response.getResponseMessage();
        this.responseObject = responseObject;
    }
}
