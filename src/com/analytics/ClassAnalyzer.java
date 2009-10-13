/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.analytics;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author dward
 */
public class ClassAnalyzer {

public ClassAnalyzer(){
  try {
   AllClassesInJVMExtractor.extractAllClassesFromJVM("C:/Java_ExtractAllFilesInClassLoader/allclasses");
  } catch (IOException ex) {
   Logger.getLogger(ClassAnalyzer.class.getName()).log(Level.SEVERE, null, ex);
  }
}

}
