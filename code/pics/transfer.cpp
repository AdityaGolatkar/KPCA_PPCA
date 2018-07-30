#include <iostream>
using namespace std;
int main()
{

	
	for (int j=1;j<=21;j++)
	{
		char c ='a';	
		cout<<"cd f"<<j<<endl;

		for (int i=1;i<=26;i++)
		{
			cout <<"cp "<<i<<".png"<<" ../alphabets/"<<c<<"/"<<j<<".png"<<endl;
			c++;
		
		}
		cout<<"cd .."<<endl;
	}
}