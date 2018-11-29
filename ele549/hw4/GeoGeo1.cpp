#include "GeoGeo1.h"
#include <math.h>
#include <time.h>
#include <iomanip>
#include <fstream>


double Seed = 7;
double myrand();

#define NumofSimPoints 12
#define SimTime 1e8
#define M 10

int main(){ 
	 
	string filename;

	cout << "Enter the result file name: ";
	cin >> filename;
	

	ofstream ofile;
	ofile.open( filename.c_str() );
    
	cout << "Lambda,AvgTaskDelay" << endl;
    ofile << "Lambda,AvgTaskDelay" << endl;

	double Lambda[NumofSimPoints] = { 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.43, 0.45, 0.47, 0.48, 0.49};
	double mu = 2;    // mean file size
	double AvgTaskDelay[NumofSimPoints] = { 0, 0, 0, 0, 0, 0, 0, 0};

	DLinkedList Queue;   // a single queue

	int i;
	long long t;
	int s;   // file size
	double xBernoulli;
	
	double TotalDelay;
	double TotalNumofCompletePkts = 0; // total number of packets which have been processed

	for (i = 0; i < NumofSimPoints; i++)     // number of arrival intensity
	{
		TotalDelay = 0;
		TotalNumofCompletePkts = 0;
		while (!Queue.empty()) Queue.removeFront();     // keep the queue empty

		for (t = 0; t < SimTime; t++)   // simulation starts
		{
			
			/*****************************************************/

			if (myrand() < Lambda[i])   /*** calls the arrival routine ***/
			{
				// geometric file size 
				s = 0;
				do {
					xBernoulli = (myrand() < (1.0 / mu));
					s = s + 1;
				} while (xBernoulli == 0);
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

				Queue.addBack(t, s);                           // insert the file into the queue
			}

			
				/*** calls the departure routine ***/
			
			if(!Queue.empty())
			{ 
				if (Queue.header->next->fSize > 1)
				{
					Queue.header->next->fSize = Queue.header->next->fSize - 1;
				}
				else
				{
					TotalDelay = TotalDelay + t - Queue.header->next->aTime;
					TotalNumofCompletePkts = TotalNumofCompletePkts + 1;
					Queue.removeFront();
				}
			}
			
		}
		
	    /******** Data Collection *******************/
	    
		AvgTaskDelay[i] = TotalDelay / TotalNumofCompletePkts;

		cout << setw(12) << setprecision(10) << Lambda[i] << ',' << setw(12) << setprecision(10) << AvgTaskDelay[i] << endl;
		ofile << setw(12) << setprecision(10) << Lambda[i] << ',' << setw(12) << setprecision(10) << AvgTaskDelay[i] << endl;
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