#include <iostream>
using namespace std;
int main()
{
	int N=26;
	for(int i=1;i<=N;i++)
	{
		cout<<"gedit "<<i<<".txt & disown"<<endl;
		cout<<"shutter -s=245,460,150,150 -o ~/code/images/"<<i<<".png -e"<<endl;
		cout<<"pkill gedit"<<endl;
	}	
}