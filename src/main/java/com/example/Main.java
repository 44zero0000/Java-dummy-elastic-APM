package com.example;

import io.javalin.Javalin;

import static io.javalin.apibuilder.ApiBuilder.crud;

public class Main {

    public static void main(String[] args) {
        StudentController sc = new StudentController();
        Javalin app = Javalin.create(
                config -> {
                    config.enableCorsForAllOrigins();
                }
        )
                .start(8080);

        app.routes(() -> crud("/students/:student-id", sc));
        app.get("/school/_count", ctx -> {
            ctx.result(sc.getStudentCount());
        });
    }
}