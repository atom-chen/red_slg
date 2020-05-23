<?php    
	$username = 'liangyuechuan';    
	$password = 'CMVNr4zfXk3X0gMirVfY';
	$code_src_url = 'svn://192.168.10.242/shenglqs/server/trunk/server/sharelib/src';
	$code_target_dir = 'sharelib';
	$cpptodxy_src_url = "svn://192.168.10.242/shenglqs/server/tools/docgen/cpptodoxy";
	$cpptodxy_target_dir = "cpptodoxy";

//    exec("dir", $output);
	exec("E:/software/TortoiseSVN/bin/svn.exe co $code_src_url $code_target_dir --username $username --password $password --no-auth-cache < password.txt 2>&1", $output);
	print_r($output);
//	$output = "";
//	exec("svn co $cpptodxy_src_url $cpptodxy_target_dir --username $username --password $password --no-auth-cache < password.txt 2>&1", $output);
//	print_r($output);
	$output = null;
	exec("docgen.bat ..\\sharelib\\", $output);
	print_r($output);
	$output = null;
	exec("copydoc.bat", $output);
	print_r($output);
	$output = null;
//	<meta http-equiv="refresh" content="3;url=../packet/modules.html"> 
?>
<head> 
</head>