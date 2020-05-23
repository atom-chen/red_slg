package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
package.path = package.path .. ";?.lua"

function ReplaceIndexHtml(srcFileName, destFileName)

	local srcFile = io.open(srcFileName, "r"); 
	if srcFile == nil
	then
		return false;
	end
	
	local destFileStr = "";
	local startLine = "<div id=\"titlearea\">";
	local endLine = "<!-- end header part -->";
	local replaceStr =	"<div id=\"titlearea\">\n" ..
				"<table cellspacing=\"0\" cellpadding=\"0\">\n" ..
				"  <tbody>\n" ..
				"  <tr style=\"height: 56px;\">\n" ..
				"    <td style=\"padding-left: 0.5em;\">\n" ..
				"      <div id=\"projectname\">TuLong\n" ..
				"        &#160;<span id=\"projectnumber\">1.0</span>\n" ..
				"        &nbsp;&nbsp;&nbsp;\n" ..
				"        <form method=\"post\" action=\"../generator_bat/docgen.php\">\n" ..
				"          <td colspan=2 align=center><button type=\"submit\" name=\"recreate\" value=\"1\">重新生成文档</button></td>\n"	..
				"        </form>\n" ..
				"      </div>\n" ..
				"    </td>\n" ..
				"  </tr>\n" ..
				"  </tbody>\n" ..
				"</table>\n" ..
				"</div>\n" ..
				"<!-- end header part -->\n";
	local startReplace = false;
	local startIgnore = false;
	for line in srcFile:lines() do
		if line == startLine
		then
			startIgnore = true;
		elseif line == endLine
		then
			startReplace = true;
		else
			if startReplace
			then
				destFileStr = destFileStr .. replaceStr;
				startIgnore = false;
				startReplace = false;
			end
			
			if startIgnore ~= true
			then
				destFileStr = destFileStr .. line .. "\n";
			end
		end
	end
	
	io.close(srcFile);

--	print(destFileStr);

	destFile = io.open(destFileName, "w");
	if destFile == nil
	then
		return false;
	end

	destFile:write(destFileStr);
	io.close(destFile);
end

local srcIndexHtmlFileName = "../doc/packet/index.html";
local destIndexHtmlFileName = "../doc/packet/index.html.html";
ReplaceIndexHtml(srcIndexHtmlFileName, destIndexHtmlFileName);