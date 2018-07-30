#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <cstring> 
using namespace std;
int main()
{	
	int N=26;
	string s;
	string ext = ".txt";
	
	ofstream myfile;
	for(int n=1;n<=N;n++)
	{
		string str;
		string name;
		cin>>s;
		stringstream ss;
		ss << n;
		str = ss.str();
		name.append(str);
		name.append(ext);
		char *y = new char[name.length()+1];
		strcpy(y,name.c_str());
		myfile.open(y);
		myfile << "\n\n\t"<<s<<"\t";
		myfile.close();
		
	}
}
