/**
 * Created by Anikan on 11/21/2014.
 */

import objectdraw.DrawingCanvas;

import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import javax.swing.*;
import javax.swing.event.*;

public class RandomEvent {
    JPanel eventPanel;
    JPanel buttonPanel;
    JLabel title;
    int numButtons;
    JButton[] buttonArray;
    JButton button1;
    JButton button2;
    JButton button3;
    JButton button4;

    public RandomEvent(File file, MainGame main) throws FileNotFoundException
    {

        eventPanel = new JPanel(new BorderLayout());
        buttonPanel = new JPanel();
        eventPanel.add(buttonPanel, BorderLayout.SOUTH);
        main.add(eventPanel, BorderLayout.CENTER);
        Scanner scanner = new Scanner(file).useDelimiter(";");
        String tText = scanner.next();
        System.out.println(tText);
        System.out.println("help");
        String eventTex = scanner.next();
        System.out.println(eventTex);
        JLabel titleText = new JLabel(tText);//scanner.next());
        JLabel eventText = new JLabel(eventTex);//scanner.next());
        eventPanel.add(titleText, BorderLayout.NORTH);
        eventPanel.add(eventText, BorderLayout.CENTER);

        numButtons = Integer.parseInt(scanner.next());

        buttonArray = new JButton[numButtons];
        for (int i = 0; i < buttonArray.length; i++)
        {
            buttonArray[i] = new JButton(scanner.next());
            buttonPanel.add(buttonArray[i]);
        }

        eventPanel.add(buttonPanel, BorderLayout.SOUTH);
    }

}
