/**
 * Created by Anikan on 11/21/2014.
 */
import objectdraw.*;
import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.io.FileNotFoundException;
import javax.swing.*;
import javax.swing.event.*;

public class MainGame extends WindowController {


    public void begin()
    {
        File file = new File("hello.txt");

        try
        {
            RandomEvent event = new RandomEvent(file, this);
            System.out.println("Worked");
        }

        catch (FileNotFoundException e)
        {

        }
    }

    public static void main(String[] args) throws FileNotFoundException
    {
        MainGame game = new MainGame();
    }

    private File loadFile(String dir)
    {
        File file = new File("hello.txt");
        return new File(dir);
    }

    private RandomEvent getEvent(File file, MainGame game) throws FileNotFoundException
    {
        return new RandomEvent(file, game);
    }


}
