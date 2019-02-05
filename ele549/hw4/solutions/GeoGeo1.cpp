#include <math.h>
#include <time.h>
#include <iomanip>
#include <fstream>
#include <iostream>
#include <string>
using namespace std;



double Seed = 7;
double myrand();

#define NumofSimPoints 5
#define SimTime 1e9

int main(){ 
	 
	string filename;

	cout << "Enter the result file name: ";
	cin >> filename;
	

	ofstream ofile;
	ofile.open( filename.c_str() );
    
	cout << "Lambda \tAvgTaskDelay" << endl;
    ofile << "Lambda \tAvgTaskDelay" << endl;

	//double epsilon[NumofSimPoints] = { 0.1, 0.08, 0.05, 0.03, 0.01, 0.008, 0.007, 0.006, 0.005, 0.0045, 0.004 };
	double epsilon[NumofSimPoints] = {0.007, 0.006, 0.005, 0.0045, 0.004 };

	double mu = 0.8;  // service rate
	double lambda;    // arrival rate 
	double meanQ[NumofSimPoints] = { 0, 0, 0, 0, 0};

	int i;
	long long t;
	double A, S, Q_next, Q_cur;
	
	long double totalQ;

	for (i = 0; i < NumofSimPoints; i++)     // number of arrival intensity
	{
		totalQ = 0;
		Q_cur = 0;

		for (t = 0; t < SimTime; t++)   // simulation starts
		{
			
			/*****************************************************/
			lambda = mu - epsilon[i];
			if (myrand() < lambda)   /*** generating arrivals***/
			{
				A = 1;
			}
			else
			{
				A = 0;
			}

			if (myrand() < mu)   /*** generating service***/
			{
				S = 1;
			}
			else
			{
				S = 0;
			}
			totalQ = totalQ + Q_cur;

			Q_next = Q_cur + A - S;
			if (Q_next < 0)
			{
				Q_next = 0;
			}
			Q_cur = Q_next;
			
		}
		
	    /******** Data Collection *******************/
	    
		meanQ[i] = totalQ / SimTime;

		cout << setw(12) << setprecision(10) << epsilon[i] << '\t' << setw(12) << setprecision(10) << meanQ[i] << endl;
		ofile << setw(12) << setprecision(10) << epsilon[i] << '\t' << setw(12) << setprecision(10) << meanQ[i] << endl;
	}

	return 0;
}

double myrand()
{
	double p;
	p = fmod(3125.0*Seed, 34359738337.0);
	Seed = p;
	p = p / 34359738337.0;
	return p;
}