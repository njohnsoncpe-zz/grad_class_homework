#include "GeoGeo1.h"
#include <math.h>
#include <time.h>
#include <iomanip>
#include <fstream>
#include <random>


double Seed = 7;
double myrand();

#define NumofSimPoints 9 //num epsilon
#define SimTime 1e8

int main(){ 
	 
	string filename;

	cout << "Enter the result file name: ";
	cin >> filename;
	

	ofstream ofile;
	ofile.open( filename.c_str() );
    
	cout << "Lambda,AvgQueueLen" << endl;
    ofile << "Lambda,AvgQueueLen" << endl;

	double mu = 0.8;    //mu for Service routines
	double Epsilon[NumofSimPoints] = {0.1, 0.08, 0.05, 0.03, 0.01, 0.008, 0.005, 0.003, 0.001};
	double Lambda = 0.0;
	double AvgQueueLength[NumofSimPoints] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};

	DLinkedList Queue;   // a single queue

	int i;
	long long t;
	double xBernoulli;


	for (i = 0; i < NumofSimPoints; i++)     // number of arrival intensity
	{
		while (!Queue.empty()) Queue.removeFront();     // keep the queue empty
		Lambda = mu - Epsilon[i];
		
		for (t = 0; t < SimTime; t++)   // simulation starts
		{
			
			/*****************************************************/
			

			if (myrand() < Lambda)   /*** calls the arrival routine ***/
			{ 
				// geometric file size 
				// do {
				// 	xBernoulli = (myrand() < (1.0 / mu));
				// 	s = s + 1;
				// } while (xBernoulli == 0);
				//Deterministic File Size
				//s = 2;
				//Markovian File Size
				/*if (myrand() < ((mu - 1)*1.0 / (M - 1)))
				{
					s = M;
				}
				else
				{
					s = 1;
				}*/

				Queue.addBack(t, 1);                           // insert the file into the queue
			}

			
				/*** calls the departure routine ***/
			
			if(myrand() < mu && !Queue.empty())
			{ 
				{
			{ 
				Queue.removeFront();
			}
			AvgQueueLength[i] += Queue.getLength();
		}
		AvgQueueLength[i] /= SimTime;

		/******** Data Collection *******************/
	    
		cout << setw(12) << setprecision(12) << Epsilon[i] << ',' << setw(12) << setprecision(12) << AvgQueueLength[i] << endl;
		ofile << setw(12) << setprecision(12) << Epsilon[i] << ',' << setw(12) << setprecision(12) << AvgQueueLength[i] << endl;
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