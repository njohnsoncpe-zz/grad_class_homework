#include "PowerDChoices.h"
#include <math.h>
#include <time.h>
#include <iomanip>
#include <fstream>
#include <list>
#include <random>

double Seed = 7;
double myrand();
double ExpRan(double);
long long GenInteger(long long);

/* random number controlled by a seed*/
unsigned long long randomX;
long long RandSeed();
double genUniformSeed(void);

int GenIntegerSeed(int);
/************************************/

int randIndex(int);
void sample(TABSServer *, double);

#define NumofServers 10000

ofstream ofile;

int main()
{

	string filename;

	cout << "Enter the result file name: ";
	cin >> filename;

	ofile.open(filename.c_str());

	ofile << setw(12) << setprecision(10) << "CurTime" << '\t'
		  << setw(12) << setprecision(10) << "numQ1" << '\t'
		  << setw(12) << setprecision(10) << "numQ2" << '\t'
		  << setw(12) << setprecision(10) << "numIdleOff" << '\t'
		  << setw(12) << setprecision(10) << "numSetup"
		  << endl;

	double TotalNumofSimPkts = 1e6;	// total number of simulated packets
	double CurNumofSimPkts = 0;		   // total number of packets which have been issued

	double nu = 0.1;	  //	start-up period constant s.t. t(setup) ~ Exp(nu)
	double mu_idle = 0.1; //	idle_on period constant s.t. t(idle_on) ~ Exp(mu_idle)

	double lambda = 0.3;	 //	Arrival Rate
	double mu_service = 1.0; //Service Rate

	TABSServer all_servers[NumofServers]; // create Servers

	int i, j, n, randInd;
	TABSServer *next_event_target; // pointer to target of next event
	int index_of_target;

	double CurTime, min_time_next_event, min_time_next_sample;

	vector<TABSServer *> green_servers;  //	list of servers that are green
	vector<TABSServer *> red_servers;	//	list of servers that are red
	vector<TABSServer *> orange_servers; //	list of servers that are orange
	vector<TABSServer *> yellow_servers; //	list of servers that are yellow

	TABSServer *tempServer;

	/***** Packet events *********/
	double time_arrival_event; // time for arrival event

	srand(time(NULL));

	CurTime = 0;
	min_time_next_sample = 0;
	CurNumofSimPkts = 0;
	index_of_target = 0;

	/** INITIAL CONDITIONS **********************************************/
	//all green
	for (n = 0; n < NumofServers; n++)
	{
		all_servers[n].setNextTransition(ExpRan(1.0 / mu_idle)); // set next transition
		all_servers[n].setNextDeparture(1e30);					 // force arrivals

		green_servers.push_back(&all_servers[n]); //add to green_servers
	}

	/** INITIAL CONDITIONS **********************************************/

	time_arrival_event = ExpRan(1.0 / (NumofServers * lambda)); // the time when the next arrival event occurs
	while (CurNumofSimPkts <= TotalNumofSimPkts)				// simulation starts
	{

		/*** Determine the type of the next occuring event ***/
		min_time_next_event = time_arrival_event; //next arrival is the next event by default

		/*** EVENT HANDLING ***/

		/** Finding Next Event **/

		//Green Servers
		if (!green_servers.empty())
		{
			for (int idx = 0; idx < green_servers.size(); idx++)
			{
				double tempTransitionTime = green_servers[idx]->getNextTransition();

				if (tempTransitionTime < min_time_next_event)
				{ //if the next event is before the old minimum, make it the new one
					min_time_next_event = tempTransitionTime;
					next_event_target = green_servers[idx];
					index_of_target = idx; //calculate index from pointer
				}
			}
		}

		//Yellow Servers
		if (!yellow_servers.empty())
		{
			for (int idx = 0; idx < yellow_servers.size(); idx++)
			{
				double tempNextDeparture = yellow_servers[idx]->getNextDeparture();
				if (tempNextDeparture < min_time_next_event)
				{ //if the next event is before the old minimum, make it the new one
					min_time_next_event = tempNextDeparture;
					next_event_target = yellow_servers[idx];
					index_of_target = idx; //calculate index from pointer
				}
			}
		}
		//Orange Servers
		if (!orange_servers.empty())
		{
			for (int idx = 0; idx < orange_servers.size(); idx++)
			{
				double tempTransitionTime = orange_servers[idx]->getNextTransition();
				if (tempTransitionTime < min_time_next_event)
				{ //if the next event is before the old minimum, make it the new one
					min_time_next_event = tempTransitionTime;
					next_event_target = orange_servers[idx];
					index_of_target = idx; //calculate index from pointer
				}
			}
		}

		CurTime = min_time_next_event; //set time to be next event time

		/** Event Execution **/
		//Arrivals
		if (min_time_next_event == time_arrival_event)
		{
			if (green_servers.empty()) //if there are no green servers, need to start another red server
			{
				randInd = randIndex(green_servers.size() - 1); //generate a random index for the vector
				tempServer = yellow_servers[randInd];		   //choose a yellow server at random
				tempServer->enqueuePacket(CurTime);			   //enqueue a packet
				CurNumofSimPkts++;							   //increment number of issued packets

				if (!red_servers.empty())
				{
					randInd = randIndex(red_servers.size() - 1); //generate a random index for the vector
					tempServer = red_servers[randInd];			 //choose a red server at random

					tempServer->setNextTransition(CurTime + ExpRan(1.0 / nu)); //set setup timer
					tempServer->setTokenColor(orange);						   //set token color to orange
					orange_servers.push_back(tempServer);					   //add to the orange_servers
					red_servers.erase(red_servers.begin() + randInd);		   //remove from the red_servers
				}
			}
			else //otherwise
			{
				randInd = randIndex(green_servers.size() - 1); //generate a random index for the vector

				tempServer = green_servers[randInd]; //choose a green server at random

				tempServer->enqueuePacket(CurTime);								  //enqueue a packet
				CurNumofSimPkts++;												  //increment number of issued packets
				tempServer->setNextDeparture(CurTime + ExpRan(1.0 / mu_service)); //generate the next departure time
				tempServer->setTokenColor(yellow);								  //change the token color

				yellow_servers.push_back(tempServer);				  //add it to the yellow_servers
				green_servers.erase(green_servers.begin() + randInd); //delete it from green_servers
			}
			time_arrival_event = CurTime + ExpRan(1.0 / (NumofServers * lambda)); //set next arrival time
		}
		//Other events
		else
		{
			switch (next_event_target->getTokenColor())
			{
			case green: // EXIT IDLE-ON EVENT
			{
				next_event_target->setTokenColor(red);						  //set target_server to red
				red_servers.push_back(next_event_target);					  //add server* to red vector
				green_servers.erase(green_servers.begin() + index_of_target); //remove server* from green vector
				break;
			}
			case orange: // EXIT SETUP EVENT
			{
				next_event_target->setTokenColor(green);							   //set target server to green
				next_event_target->setNextTransition(CurTime + ExpRan(1.0 / mu_idle)); //set idle-on timer

				green_servers.push_back(next_event_target);						//add server* to green vector
				orange_servers.erase(orange_servers.begin() + index_of_target); //remove server* from green vector
				break;
			}
			case yellow: // DEPARTURE EVENT
			{
				next_event_target->servicePacket(); //service packet
				if (next_event_target->queueEmpty())
				{																		   //if the server queue is empty
					next_event_target->setTokenColor(green);							   //set target server to green
					next_event_target->setNextTransition(CurTime + ExpRan(1.0 / mu_idle)); //set idle-on timer
					green_servers.push_back(next_event_target);							   //add server* to green vector
					yellow_servers.erase(yellow_servers.begin() + index_of_target);		   //remove server from yellow_servers
				}
				break;
			}
			}
		}
		if (CurTime > min_time_next_sample)
		{
			sample(all_servers, CurTime);
			min_time_next_sample = CurTime + 1;
		}
	}
	cout << "done" << endl;
	return 0;
}

double myrand()
{
	double p;
	p = fmod(3125.0 * Seed, 34359738337.0);
	Seed = p;
	p = p / 34359738337.0;
	return p;
}

double ExpRan(double mean)
{
	double u, p;
	u = myrand();
	p = -mean * log(u);
	return p;
}

long long GenInteger(long long z)
{
	double u;
	long long p;
	u = myrand();
	p = (long long)(z * u);
	return p;
}

long long RandSeed()
{
	static const unsigned long long a = 1664525;
	static const unsigned long long c = 1013904223;
	static const unsigned long long m = 0xFFFFFFFF;

	return randomX = (randomX * a + c) & m;
}

double genUniformSeed(void)
{
	const unsigned long long max = 0xFFFFFFFF;
	return (double)RandSeed() / (double)(max + 1);
}

int GenIntegerSeed(int z)
{
	double u;
	int p;
	u = genUniformSeed();
	p = (int)(z * u);
	return p;
}

int randIndex(int len)
{
	return (int)((double)rand() / ((double)RAND_MAX + 1) * (len + 1));
}

void sample(TABSServer *servers, double currentTime)
{

	int numQ1 = 0;
	int numQ2 = 0;
	int numIdleOff = 0;
	int numSetup = 0;

	for (int idx = 0; idx < NumofServers; idx++)
	{
		int qLen = servers[idx].getQueueLength();
		Color token = servers[idx].getTokenColor();

		if (qLen >= 1)
		{
			numQ1++; //Q1 Sample
		}
		if (qLen >= 2)
		{
			numQ2++; //Q2 Sample
		}

		switch (token)
		{
		case green:
			//count IdleOn here
			break;
		case yellow:
			//count Busy here
			break;
		case orange:
			numSetup++; //Setup (Orange) Sample
			break;
		case red:
			numIdleOff++; //Idle-off (Red) Sample
			break;
		}
	}

	ofile << setw(12) << setprecision(10) << currentTime << '\t'
		  << setw(12) << setprecision(10) << numQ1 << '\t'
		  << setw(12) << setprecision(10) << numQ2 << '\t'
		  << setw(12) << setprecision(10) << numIdleOff << '\t'
		  << setw(12) << setprecision(10) << numSetup << '\t'
		  << endl;
}