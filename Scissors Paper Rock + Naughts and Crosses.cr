using System;

public class Program()
{

	public static void Main()
	{
		
		Console.WriteLine("Choose a game by typing in either 'spr' or 'ttt'");
		string response = Console.ReadLine();		 
		if (response.ToLower() == "ttt") {
			naughtcross();
		} else if (response.ToLower() == "spr"){
			SPR();
		} else {
			Console.WriteLine("Invalid Input");
			Main();
		}
	}
	
	private static void naughtcross() {
		string[,] tttlist =  {{"1", "2", "3"},
							  {"4", "5", "6"},
							  {"7", "8", "9"}};

		Random Playerpick = new Random();
		int turn = Playerpick.Next(2);
		if (turn == 0) { // player 1 (X) goes first
			for (int i = 0; i <= 4; i++) {
				TTTdraw(tttlist);
				Console.WriteLine("Player 1, pick a number");
				Console.WriteLine();
				tttlist = TTTpick(tttlist, "X");
				naughtcrosswincheck(tttlist, "X");
				Console.WriteLine();
				TTTdraw(tttlist);
				Console.WriteLine("Player 2, pick a number");
				Console.WriteLine();
				tttlist = TTTpick(tttlist, "0");
				naughtcrosswincheck(tttlist, "0");
			}
		} else if (turn == 1) { // player 2 (0) goes first
			for (int i = 0; i <= 4; i++) {
				TTTdraw(tttlist);
				Console.WriteLine("Player 2, pick a number");
				Console.WriteLine();
				tttlist = TTTpick(tttlist, "0");
				naughtcrosswincheck(tttlist, "0");
				Console.WriteLine();
				TTTdraw(tttlist);
				Console.WriteLine("Player 1, pick a number");
				Console.WriteLine();
				tttlist = TTTpick(tttlist, "X");
				naughtcrosswincheck(tttlist, "X");
			}
		}
	}
	
	private static void TTTdraw(string[,] tttlist)
	{
			Console.WriteLine("    |   |    ");
			Console.WriteLine("  " + tttlist[0,0] + " | " + tttlist[0,1] + " | " + tttlist[0,2] + "   ");
			Console.WriteLine("____|___|____");
			Console.WriteLine("    |   |    ");
			Console.WriteLine("  " + tttlist[1,0] + " | " + tttlist[1,1] + " | " + tttlist[1,2] + "   ");
			Console.WriteLine("____|___|____");
			Console.WriteLine("    |   |    ");
			Console.WriteLine("  " + tttlist[2,0] + " | " + tttlist[2,1] + " | " + tttlist[2,2] + "   ");
			Console.WriteLine("    |   |    ");
	}
	
	private static string[,] TTTpick(string[,] tttlist, string nc)
	{
		//string place = Console.ReadLine();
		bool convertable = false;
		bool valid = false;
		int number = 0;
		do {
			do {
				string place = Console.ReadLine();
				convertable = int.TryParse(place, out number);
				if (convertable == false) {
					Console.WriteLine("Invalid Input");
				}
				//Console.WriteLine("gr");
			}
			while (convertable == false);
			for (int i = 0; i < 3; i++) {
				for (int j = 0; j < 3; j++) {
					if (tttlist[i,j] == number.ToString()) {
						Console.WriteLine("You picked number " + number.ToString());
						if (tttlist[i,j] != "0" && tttlist[i,j] != "X") {
							tttlist[i,j] = nc;
							valid = true;
							//return tttlist;
						}
					}
				}
			}
		}
		while (valid == false);
		return tttlist;
	}
	
	private static void naughtcrosswincheck(string[,] tttlist, string nc)
	{
		// possible win combos (1,2,3), (4,5,6), (7,8,9), (1,4,7), (2,5,8), (3,6,9), (1,5,9), (3,5,7) 5689
		// 2d array win combos (00,01,02), (10,11,12), (20,21,22), (00,10,20), (01,11,21), (02,12,22), (00,11,22), (02,11,20)
		
		// win combos starting with 00 (00,01,02), (00,10,20), (00,11,22)
		// win combos starting with 10 (10,11,12)
		// win combos starting with 20 (20,21,22)
		// win combos starting with 01 (01,11,21)
		// win combos starting with 02 (02,12,22), (02,11,20)
		
	string[,] wincombos = {{"00", "01", "02"},
							   {"0,0", "1,0", "2,0"},
							   {"0,0", "1,1", "2,2"},
							   {"1,0", "1,1", "1,2"},
							   {"2,0", "2,1", "2,2"},
							   {"0,1", "1,1", "2,1"},
							   {"0,2", "1,2", "2,2"},
							   {"0,2", "1,1", "2,0"}}; 
		
		string[] check = new string[3] ;
		
		for (int k = 0; k < 8; k++) {
			for (int e = 0; e < 3; e++) {
				for (int i = 0; i < 3; i++) {
					for (int j = 0; j < 3; j++) {
						//Console.WriteLine(tttlist[i,j]);
						if (tttlist[i,j] == nc) {
							//Console.WriteLine("0 at [" + i + "," + j + "]");
							//for (int k = 0; k < 8; k++) {
							string check2 = i.ToString() + "," + j.ToString();
							if (wincombos[k,e] == check2) {
								//Console.WriteLine("gre");
								check[e] = check2;
								//Console.WriteLine(check[0] + check[1] + check[2]);
								if (e == 2) {
									string check3 = check[0] + check[1] + check[2];
									//Console.WriteLine(check3);
									if (check3 == wincombos[k,0] + wincombos[k,1] + wincombos[k,2]) {
										if (nc == "X") {
											TTTdraw(tttlist);
											Console.WriteLine("Player 1 wins");
											Console.WriteLine();
											Console.WriteLine();
											Main();
										} else if (nc == "0") {
											TTTdraw(tttlist);
											Console.WriteLine("Player 2 wins");
											Console.WriteLine();
											Console.WriteLine();
											Main();
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	
	private static void SPR()
	{
		Random rand = new Random();
		int randompick = rand.Next(0,3); // 0 scissors, 1 paper, 2 rock
		string[] compchoice = {"Computer chose scissors", "Computer chose paper", "Computer chose rock"};
		Console.WriteLine("Type in 'scissors', 'paper', or 'rock' to make your choice");
		string answer = Console.ReadLine();
		Console.WriteLine(compchoice[randompick]);
		if (answer == "scissors"){
			if (randompick == 0){
				Console.WriteLine("It's a Draw");
				Console.WriteLine();
				Console.WriteLine();
			} else if (randompick == 1){
				Console.WriteLine("You Win");
				Console.WriteLine();
				Console.WriteLine();
			} else if (randompick == 2){
				Console.WriteLine("You Lose");
				Console.WriteLine();
				Console.WriteLine();
			}
		} else if (answer == "paper"){
			if (randompick == 0){
				Console.WriteLine("You Lose");
				Console.WriteLine();
				Console.WriteLine();
				Main();
			} else if (randompick == 1){
				Console.WriteLine("It's a Draw");
				Console.WriteLine();
				Console.WriteLine();
				Main();
			} else if (randompick == 2){
				Console.WriteLine("You Win");
				Console.WriteLine();
				Console.WriteLine();
				Main();
			}
		} else if (answer == "rock"){
			if (randompick == 0){
				Console.WriteLine("You Win");
				Console.WriteLine();
				Console.WriteLine();
				Main();
			} else if (randompick == 1){
				Console.WriteLine("You Lose");
				Console.WriteLine();
				Console.WriteLine();
				Main();
			} else if (randompick == 2){
				Console.WriteLine("It's a Draw");
				Console.WriteLine();
				Console.WriteLine();
				Main();
			}
		} 
	
	}
}
