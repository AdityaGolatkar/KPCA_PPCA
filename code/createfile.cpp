#include <iostream>
#include <sstream>
#include <string>
using namespace std;
int main()

{
	int n;
	cin>>n;

	
	string s;
	string ext = ".txt";
	
	for(int i=1;i<=n;i++)
	{
		stringstream ss;
		ss<<i;
		s = ss.str();
		s.append(ext);
		cout<<"touch "<<s<<endl;
	}
	
2}