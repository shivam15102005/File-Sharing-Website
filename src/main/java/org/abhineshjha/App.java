package org.abhineshjha;

import java.io.IOException;
import org.abhineshjha.controller.FileController;

public class App {
    public static void main(String[] args) {
        try {
            // Get the PORT from environment variables (Render sets this automatically)
            int port = Integer.parseInt(System.getenv().getOrDefault("PORT", "8080"));

            // Start the API server
            FileController fileController = new FileController(port);
            fileController.start();

            System.out.println("PeerLink server started on port " + port);
            System.out.println("UI available at http://localhost:3000");

            // Graceful shutdown hook
            Runtime.getRuntime().addShutdownHook(new Thread(() -> {
                System.out.println("Shutting down server...");
                fileController.stop();
            }));

            // Wait for manual stop (only relevant locally)
            if (System.getenv("RENDER") == null) {
                System.out.println("Press Enter to stop the server");
                System.in.read();
                fileController.stop();
            }

        } catch (IOException e) {
            System.err.println("Error starting server: " + e.getMessage());
            System.exit(1);
        }
    }
}
