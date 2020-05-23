package com.game.lib;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader; 
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import android.content.Context;
import android.util.Log;

public class AssetsFileCopy {   

	public static String startCopy(Context context,String filename) throws IOException{
			InputStream instream=context.getAssets().open(filename);
			int size = instream.available();
			byte[] buffer = new byte[size];
			instream.read(buffer);    
			instream.close(); 
			String str=new String(buffer);  
			return str; 
	}
	
	public static boolean copyFile(Context context,String filename,String to){ 
		
		InputStream instream = null ;
		try {
			instream = context.getAssets().open(filename);     
			copyFile(to, instream);
		} catch (IOException e) { 
			// TODO Auto-generated catch block  
			e.printStackTrace(); 
			return false;
		} 
		
		return true;
		
	} 
	
	public static void copyFile(String to,InputStream instream) throws IOException{
		Log.w("bb",to);
		OutputStream outstream = null;
		File file = new File(to);
		File parent = file.getParentFile();  
		if(!parent.exists()){
			parent.mkdirs();
		}
		if(!file.exists())  
		   file.createNewFile();
		
		try {
			outstream = new FileOutputStream(file);
			byte[] buffer = new byte[5*1024];
			int count = 0;
			while((count = instream.read(buffer))!=-1){
				outstream.write(buffer, 0, count);
				outstream.flush();
			}
		} finally{  
			if(instream != null){ 
				instream.close();
			}
			if(outstream !=null){
				outstream.flush();
				outstream.close();
			} 
		} 
		
	}
	
	
	public static void deepCopyAssetsFile(Context ctxDealFile, String path,String to) {
        try {
            String str[] = ctxDealFile.getAssets().list(path);
            if (str.length > 0) {//如果是目录
            	
                File file = new File(to+File.separator + path);
//                File parent = file.getParentFile();
//                if (!parent.exists()){
//                	parent.mkdirs();
//                }
                if(!file.exists()){
                	file.mkdirs();
                }
                for (String string : str) {
                    String nextPath = path+File.separator  + string;
                    //Log.w("list",nextPath);
//                    System.out.println("zhoulc:\t" + path);
                    // textView.setText(textView.getText()+"\t"+path+"\t");
                    deepCopyAssetsFile(ctxDealFile, nextPath,to);
//                    path = path.substring(0, path.lastIndexOf('/'));
                }
            } else {//如果是文件
            	//Log.w("file",path);
            	copyAssetFile(ctxDealFile,path,to);
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
	
	public static void copyAssetFile(Context ctxDealFile,String path,String to) throws IOException{
		InputStream is = null;
		FileOutputStream fos = null;
		try {
			is = ctxDealFile.getAssets().open(path);
			File file = new File(to +File.separator + path);
//			File parent = file.getParentFile();
//          if (!parent.exists()){
//          	parent.mkdirs();
//          }
			Log.w(path, to);  
			fos = new FileOutputStream(file);
			
	         byte[] buffer = new byte[1024];
	         while (true) {
	             int len = is.read(buffer);
	             if (len == -1) {
	                 break;
	             }
	             fos.write(buffer, 0, len);
	         }
		} finally {
            // 关闭流
            if (is != null)
            	is.close();
            if (fos != null)
            	fos.close();
        }
	}
	
	
	// 复制文件
    public static void copyFile(File sourceFile, File targetFile) throws IOException {
        BufferedInputStream inBuff = null;
        BufferedOutputStream outBuff = null;
        try {
            // 新建文件输入流并对它进行缓冲
            inBuff = new BufferedInputStream(new FileInputStream(sourceFile));

            // 新建文件输出流并对它进行缓冲
            outBuff = new BufferedOutputStream(new FileOutputStream(targetFile));

            // 缓冲数组
            byte[] b = new byte[1024 * 5];
            int len;
            while ((len = inBuff.read(b)) != -1) {
                outBuff.write(b, 0, len);
            }
            // 刷新此缓冲的输出流
            outBuff.flush();
        } finally {
            // 关闭流
            if (inBuff != null)
                inBuff.close();
            if (outBuff != null)
                outBuff.close();
        }
    }

    // 复制文件夹
    public static void copyDirectiory(String sourceDir, String targetDir) throws IOException {
        // 新建目标目录
    	File toFile = new File(targetDir);
    	if(!toFile.exists()){
    		toFile.mkdirs();
    	}
        // 获取源文件夹当前下的文件或目录
        File[] file = (new File(sourceDir)).listFiles();
        for (int i = 0; i < file.length; i++) {
            if (file[i].isFile()) {
                // 源文件
                File sourceFile = file[i];
                // 目标文件
                File targetFile = new File(new File(targetDir).getAbsolutePath() + File.separator + file[i].getName());
                copyFile(sourceFile, targetFile);
            }
            if (file[i].isDirectory()) {
                // 准备复制的源文件夹
                String dir1 = sourceDir + File.separator + file[i].getName();
                // 准备复制的目标文件夹
                String dir2 = targetDir + File.separator + file[i].getName();
                copyDirectiory(dir1, dir2);
            }
        }
    }
	
	public static String readFileByLines(String fileName) {
		String str = "";
        File file = new File(fileName);
        BufferedReader reader = null;
        try {
//            System.out.println("以行为单位读取文件内容，一次读一整行：");
            reader = new BufferedReader(new FileReader(file));
            String tempString = null;
//            int line = 1;
            // 一次读入一行，直到读入null为文件结束
            while ((tempString = reader.readLine()) != null) {
                // 显示行号
            	str = str + tempString;
//                line++;
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
        }
        return str;
    }
}
