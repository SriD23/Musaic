package musaic.musaic;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

// Inner Class for network threading
class ClientThread extends Thread {
    private BufferedReader br;
    private PrintWriter pw;
    private String name;
    private Socket s;
    private Scanner scan;
    private boolean sessionEnds = false;

    public ClientThread(String hostname, int port, String username, String message, Boolean remove) {
        try {
            s = new Socket(hostname, port);
            br = new BufferedReader(new InputStreamReader(s.getInputStream()));
            pw = new PrintWriter(s.getOutputStream(), true);
            start();
            name = username;
            if (remove){
                pw.println((name + " unliked song: " + message));
            }
            else {
                pw.println((name + " liked song: " + message));
            }
//            do {
//                pw.println(name + ": " + message);
//
//            } while (!message.equals("quit"));
            sessionEnds = true;
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    public void run() {
        try {
            while (true) {
                String line = br.readLine();
                System.out.println(line + "check");
                if (sessionEnds) break;
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        } finally {
            try {
                pw.close();
                br.close();
                s.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
}
