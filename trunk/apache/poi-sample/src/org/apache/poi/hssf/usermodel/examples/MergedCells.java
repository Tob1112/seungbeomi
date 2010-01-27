
/* ====================================================================
   Licensed to the Apache Software Foundation (ASF) under one or more
   contributor license agreements.  See the NOTICE file distributed with
   this work for additional information regarding copyright ownership.
   The ASF licenses this file to You under the Apache License, Version 2.0
   (the "License"); you may not use this file except in compliance with
   the License.  You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
==================================================================== */


package org.apache.poi.hssf.usermodel.examples;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.Region;

import java.io.IOException;
import java.io.FileOutputStream;

/**
 * An example of how to merge regions of cells.
 *
 * @author Glen Stampoultzis (glens at apache.org)
 */
public class MergedCells
{
   public static void main(String[] args)
        throws IOException
    {
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("new sheet");

        HSSFRow row = sheet.createRow((short) 1);
        HSSFCell cell = row.createCell((short) 1);
        cell.setCellValue("This is a test of merging");
        HSSFCellStyle style = wb.createCellStyle();
       // style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style.setAlignment(HSSFCellStyle.VERTICAL_TOP);

        cell.setCellStyle(style);

        sheet.addMergedRegion(new Region(
        			1,	(short)1,
        			2,	(short)2
        ));

        HSSFRow row2 = sheet.createRow((short) 3);
        HSSFCell cell2 = row2.createCell((short) 3);
        cell2.setCellValue("This is a test of merging");
        cell.setCellStyle(style);
        sheet.addMergedRegion(new Region(3, (short)3 , 4, (short)4 ));

        // Write the output to a file
        FileOutputStream fileOut = new FileOutputStream("workbook.xls");
        wb.write(fileOut);
        fileOut.close();

    }
}
