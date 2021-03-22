#ifndef DEM_HEADER_H
#define DEM_HEADER_H

#include <string>
#include <algorithm>
#include <fstream>
#include <queue>
#include <functional>

#define NO_DATA_VALUE -9999.0f
#include "types.h"

/*
*	reverse flow direction
*	2	4	8
*	1	0	16
*	128	64	32
*/
static unsigned char inverse[8] = {16, 32, 64, 128, 1, 2, 4, 8};
/*
*	flow direction		
*	32	64	128		
*	16	0	1		
*	8	4	2		
*/
static unsigned char dir[8] = {1, 2, 4, 8, 16, 32, 64, 128};
class DEM
{
protected:
	float* pDem;
	bigint width, height;
public:
	DEM()
	{
		pDem=NULL;
	}
	~DEM()
	{
		delete[] pDem;
	}
	bool Allocate();

	void freeMem();

	void initialElementsNodata();
	float asFloat(bigint row, bigint col) const;
	void Set_Value(bigint row, bigint col, float z);
	bool is_NoData(bigint row, bigint col) const;
	void Assign_NoData();
	int Get_NY() const;
	int Get_NX() const;
	float* getDEMdata() const;

	void SetHeight(bigint height);
	void SetWidth(bigint width);
	void readDEM(const std::string& filePath);
	bool is_InGrid(bigint row, bigint col) const;
	float getLength(unsigned int dir);
	unsigned char computeDirection(bigint row, bigint col, float spill);
};
#endif
