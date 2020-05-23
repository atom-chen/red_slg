#ifndef __UIFRAME__H__
#define __UIFRAME__H__



struct UIFrameSize
{
	int width, height;
};

struct Border
{
	UIFrameSize top;
	UIFrameSize bottom;
	UIFrameSize left;
	UIFrameSize right;
}g_border[] = 
{
	{{729, 41}, {776, 19}, {19, 457}, {19, 457}},
	{{776, 19}, {776, 19}, {19, 457}, {19, 457}},
};

struct UIFrameRect
{
	int x, y, width, height;
	UIFrameRect()
	{
		Zero();
	}
	void Zero()
	{
		x = y = width = height = 0;
	}
	
	static UIFrameRect getContentRect(int FrameType, int x, int y, int width, int height);
};


#endif