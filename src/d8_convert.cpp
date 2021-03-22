#include <time.h>

#include <algorithm>
#include <fstream>
#include <iostream>
#include <list>
#include <queue>
#include <stack>
#include <string>
#include <unordered_map>

#include "DEM.h"
#include "FlowDirection.h"
#include "utils.h"


using namespace std;
using std::cout;
using std::endl;
using std::fstream;
using std::getline;
using std::ifstream;
using std::string;


//Fill depresspions and calculate flow directions from input DEM using the algorithm in Wang and Liu (2006)
// convert gis2tau
void d8_convert(char* inputFile, char* outputDirPath) {
    FlowDirection dirDEM;
    double geoTransformArgs[6];

    if (!readTIFF(inputFile, GDALDataType::GDT_Byte, dirDEM, geoTransformArgs)) {
        cout << "Error occured when reading DEM!" << endl;
        return;
    }

    bigint width = dirDEM.Get_NX();
    bigint height = dirDEM.Get_NY();

    //Prepare a flag array of Boolean values
    bigint nums = (width * height + 7) / 8;
    cout << "dirDEM width:" << width << "\theight：" << height << "\tnums：" << nums << endl;

    time_t timeStart, timeEnd;
    timeStart = time(NULL);

    unsigned char d8_gis[] = {1, 2, 4, 8, 16, 32, 64, 128};
    unsigned char d8_tau[] = {1, 8, 7, 6, 5, 4, 3, 2};
    // if invert, then exchange d8_gis and d8_tau
    // int nd8 = 8;
    for (int row = 0; row < height; row++) {
        for (int col = 0; col < width; col++) {
            // if find, jump to here
            if (!dirDEM.is_NoData(row, col)) {
                for (int k = 0; k < 8; k++) {
                    if (dirDEM.asByte(row, col) == d8_gis[k]) {
                        dirDEM.Set_Value(row, col, d8_tau[k]);
                        break;
                    }
                }
            }
        }
    }

    cout << "Finish convert flowdirection from ArcGIS style to Taudem." << endl;
    timeEnd = time(NULL);

    double consumeTime = difftime(timeEnd, timeStart);
    cout << "Times used: " << consumeTime << " seconds" << endl;

    cout << "Writing flow direction matrix ..." << endl;
    double min, max, mean, stdDev;
    calculateStatistics(dirDEM, &min, &max, &mean, &stdDev);
    CreateGeoTIFF(outputDirPath, dirDEM.Get_NY(), dirDEM.Get_NX(),
                  (void*)dirDEM.getData(), GDALDataType::GDT_Byte, geoTransformArgs,
                  &min, &max, &mean, &stdDev, 0);
    cout << "Flow direction grid created!" << endl;
}

int main(int argc, char* argv[]) {

    if (argc < 3) {
        cout << "d8_convert [infile]:dir_arcgis [outfile]:dir_taudem\n"
             << endl;
        return 1;
    }

    // char* algName = argv[1];
    char* inputPath = argv[1];
    char* outputPath = argv[2];

    d8_convert(inputPath, outputPath);
    return 0;
}
