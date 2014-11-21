import objectdraw.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;

public class MonthDistribution 
extends WindowController
implements ChangeListener
{

    private static int budget = 0;

    private JPanel topPanel;
    private JLabel budgetLabel;

    private JSpinner carExpense;
    private JSpinner rentExpense;
    private JSpinner foodExpense;
    private SpinnerModel carSpinnerModel;
    private SpinnerModel rentSpinnerModel;
    private SpinnerModel foodSpinnerModel;

    public void begin(){
        topPanel = new JPanel();
        budgetLabel = new JLabel("Budget: $" + budget);

        carSpinnerModel =
            new SpinnerNumberModel(400, //initial value
                    0, //min
                    1000, //max
                    1);//step
        rentSpinnerModel =
            new SpinnerNumberModel(400, //initial value
                    0, //min
                    1000, //max
                    1);//step
        foodSpinnerModel =
            new SpinnerNumberModel(400, //initial value
                    0, //min
                    1000, //max
                    1);//step

        carExpense = new JSpinner(carSpinnerModel);
        rentExpense = new JSpinner(rentSpinnerModel);
        foodExpense = new JSpinner(foodSpinnerModel);

        topPanel.add(budgetLabel);
        topPanel.add(carExpense);
        topPanel.add(rentExpense);
        topPanel.add(foodExpense);


        refreshBudget();

        this.add(topPanel,BorderLayout.NORTH);
        //this.add(budgetLabel);
        carExpense.addChangeListener(this);
        rentExpense.addChangeListener(this);
        foodExpense.addChangeListener(this);
        this.validate();
    }
    public void stateChanged(ChangeEvent evt)
    {
        refreshBudget();
    }
    public void refreshBudget(){
        budget =4000-
            ((Integer)carSpinnerModel.getValue() +
            (Integer)rentSpinnerModel.getValue() +
            (Integer)foodSpinnerModel.getValue());
        budgetLabel.setText("Budget: $" + (budget));
        this.validate();


    }
}
