/**
 * Created by Anikan on 11/21/2014.
 */

import objectdraw.DrawingCanvas;
import objectdraw.*;
import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import javax.swing.*;
import javax.swing.event.*;

public class RandomEvent extends WindowController{
    //JPanel eventPanel;
    JPanel buttonEventPanel, titleEventPanel;
    JLabel title;
    int numButtons;
    JButton[] buttonArray;
    JButton button1;
    JButton button2;
    JButton button3;
    JButton button4;
    JButton testVar;

    public RandomEvent(File file, MainGame main) throws FileNotFoundException
    {
        Container eventPanel = getContentPane();
        buttonEventPanel = new JPanel();
        titleEventPanel = new JPanel();

        Scanner scanner = new Scanner(file).useDelimiter(";");
        String tText = scanner.next();
        System.out.println(tText);
        System.out.println("help");
        String eventTex = scanner.next();
        System.out.println(eventTex);
        JLabel titleText = new JLabel(tText);//scanner.next());
        JLabel eventText = new JLabel(eventTex);//scanner.next());
        titleEventPanel.add(titleText, BorderLayout.NORTH);
        titleEventPanel.add(eventText, BorderLayout.SOUTH);

        numButtons = Integer.parseInt(scanner.next());
        System.out.println(numButtons);

        buttonArray = new JButton[numButtons];
        for (int i = 0; i < buttonArray.length; i++)
        {
            buttonArray[i] = new JButton(scanner.next());
            buttonEventPanel.add(buttonArray[i]);
        }
        for (int i = 0; i < buttonArray.length; i++) {
          System.out.println(buttonArray[i].getText());
        }
        main.add(buttonEventPanel, BorderLayout.SOUTH);
        main.add(titleEventPanel, BorderLayout.NORTH);
        main.validate();
    }
}
