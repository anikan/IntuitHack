package packag;

public class FactorInATaxRate {
	public static void main(String[] args) {
		
		
				
		double amount;
		//starting amount
		double principle = 10000;
		//the rate of increase
		double rate = .08;
		
		for (int day = 1; day <= 20; day++){
			amount = principle * Math.pow(1+rate, day);
			System.out.println(day + " " + amount); 
		}
	}
}
