#include "UIFrame.h"


UIFrameRect UIFrameRect::getContentRect(int FrameType, int x, int y, int width, int height)
{
	UIFrameRect r;
	if (FrameType >= sizeof(g_border)/sizeof(g_border[0]))
	{
		return r;
	}
	
	int borderWidth = g_border[FrameType].left.width + g_border[FrameType].right.width;
	int borderHeight = g_border[FrameType].top.height + g_border[FrameType].bottom.height;
	
	if (borderWidth > width)
		return r;
	
	if (borderHeight >= height)
		return r;
	
	r.x = x + g_border[FrameType].left.width;
	r.y = y + g_border[FrameType].top.height;
	r.width = width - borderWidth;
	r.height = height - borderHeight;
	return r;
}

