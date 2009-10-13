package com.analytics;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;

/***
 * This class extracts all classes loaded in the JVM and their binary contents
 * (.class files) into given directory so that you can create JAR archive later.
 * @author Svetlin Nakov - http://www.nakov.com
 */
public class AllClassesInJVMExtractor {

	private final static int BUFFER_SIZE = 4096;

	public static void extractAllClassesFromJVM(String destFolder)
			throws IOException {
		ClassLoader appLoader = ClassLoader.getSystemClassLoader();
		ClassLoader currentLoader = AllClassesInJVMExtractor.class.getClassLoader();

		ClassLoader[] loaders = new ClassLoader[] { appLoader, currentLoader };
		final Class<?>[] classes = ClassScope.getLoadedClasses(loaders);
		for (Class<?> cls : classes) {
			String className = cls.getName();
			URL classLocation = ClassScope.getClassLocation(cls);
			System.out.println("Extracting class: " + className + " from " + 
					classLocation);
			String destFileName = destFolder + "/"
					+ className.replace(".", "/") + ".class";
			copyFile(classLocation, destFileName);
		}
	}

	private static void copyFile(URL sourceURL, String destFileName)
			throws IOException {
		File destFile = new File(destFileName);
		File destDirectory = destFile.getParentFile();
		destDirectory.mkdirs();
		InputStream srcStream = sourceURL.openStream();
		try {
			OutputStream destStream = new FileOutputStream(destFile);
			try {
				copyStreams(srcStream, destStream);
			} finally {
				destStream.close();
			}
		} finally {
			srcStream.close();
		}
	}

	private static void copyStreams(InputStream srcStream,
			OutputStream destStream) throws IOException {
		byte[] buf = new byte[BUFFER_SIZE];
		while (true) {
			int bytesRead = srcStream.read(buf);
			if (bytesRead == -1) {
				// End of stream reached
				return;
			}
			destStream.write(buf, 0, bytesRead);
		}
	}

}
