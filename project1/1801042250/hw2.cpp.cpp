#include <iostream>

#define MAX_SIZE (40)

using namespace std;


int CheckSumPossibility( int num, int arr[], int size){

    if( num == 0 )
        return 1;
    else if( num < 0 || size == 0 )
        return 0;
    
    return (CheckSumPossibility(num - arr[size-1], arr, size-1) || CheckSumPossibility(num, arr, size-1)  );
}

//8 129 95 42 27 36 91 4 2 53 -> 1
//8 129 41 67 34 0 69 24 78 58 -> 0
//8 129 62 64 5 45 81 27 61 91 -> 0
//8 129 92 82 21 16 18 95 47 26 -> 1
//8 129 71 38 69 12 67 99 35 94 -> 1
//8 129 3 11 22 33 73 64 41 11  -> 0

int main(){
    int arraySize, num, returnVal;
    int arr[MAX_SIZE];
    int i = 0;

    cout << "Enter size of the array : ";
    cin >> arraySize;

    if( arraySize > MAX_SIZE || arraySize < 0 ){
        cout << "INVALID VALUE!" << endl;
        exit(1);
    }

    cout << "Enter subset sum : ";
    cin >> num;

    if( num < 0 ){
        cout << "INVALID VALUE!" << endl;
        exit(1);
    }

    while( i < arraySize ){
        cin >> arr[i];

        if( arr[i] < 0 )
            cout << "INVALID VALUE! Must be greater than 0!" << endl;
        else 
            i++;
    }
        

    returnVal = CheckSumPossibility(num, arr, arraySize);

    if( returnVal == 1)
        cout << "Possible!" << endl;
    else
        cout << "Not possible!" << endl;



    return 0;
}