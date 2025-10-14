# SQL2Excel Version History

## v1.2.6 - Validation & Structure Improvements (2025-01-XX)

### ✨ New Features
- **Sheet Name Validation**: Added Excel sheet name validation logic
  - Invalid character validation: `\`, `/`, `*`, `?`, `[`, `]`, `:`
  - Maximum length validation: 31 character limit
  - Leading/trailing whitespace validation
  - Actual sheet name validation after variable substitution

- **XML Structure Validation**: Added element and attribute name validation logic
  - Allowed elements validation
  - Allowed attributes validation
  - Automatic exclusion of xml2js internal keys (`$`, `_`, etc.)
  - Detailed error message output

- **Interactive Menu System**: User-friendly menu system in sql2db style
  - `app.js`: Multi-language menu system
  - `run.bat`: English version launcher script
  - `실행하기.bat`: Korean version launcher script

### 🔧 Technical Improvements
- **Improved dbinfo.json Structure**: Removed dbs wrapper
  - Before: `{"dbs": {"sampleDB": {...}}}`
  - After: `{"sampleDB": {...}}`
  - More concise structure for better readability

- **pkg Environment Path Handling**: Using APP_ROOT constant
  - `mssql-connection-manager.js`: Added pkg environment path handling
  - Unified all file paths based on APP_ROOT

### 🐛 Bug Fixes
- **queryDef validation error**: Improved id attribute recognition in queryDef
- **Variable substitution sheet name validation**: Changed to validate after variable substitution
- **validate command option parsing**: Improved --xml option recognition

## v1.2.5 - Batch Interface Improvements (2025-10-10)

### 🔧 Improvements
- **📋 Numbered File Selection**: Changed file selection from manual path entry to numbered menu system
- **✅ Enhanced Input Validation**: Added validation for file selection numbers
- **🎯 Improved User Experience**: More intuitive file selection with automatic listing of XML/JSON files
- **🔍 File Type Detection**: Automatic detection and separation of XML and JSON files in selection menus
- **📁 Empty Directory Handling**: Better handling when no query definition files are found

### 🪟 Batch Interface Changes
- **VALIDATE Menu**: Display numbered list of all query files (XML/JSON) for validation
- **EXPORT_XML Menu**: Display numbered list of XML files with simplified selection
- **EXPORT_JSON Menu**: Display numbered list of JSON files with simplified selection
- **Input Validation**: Check if number is in valid range and provide clear error messages
- **User Feedback**: Show selected file path before processing

---

## v1.2.4 - Standalone Executable & Enhanced User Experience (2025-10-05)

### ✨ New Features
- **📦 Standalone Executable Generation**: Generate versioned standalone .exe files without Node.js dependency
- **🌐 Multi-language Release Packages**: Automated Korean and English release package generation
- **🕒 Creation Timestamp Display**: Show creation timestamp on each Excel sheet
- **⏰ Enhanced DateTime Variables**: 20+ automatic datetime variables for real-time timestamp generation
- **📋 SQL Query Formatting**: Preserve original SQL formatting with line breaks in Table of Contents
- **🔧 Input Validation**: Automatic whitespace trimming for file path inputs in batch interface
- **🚀 Release Automation**: Complete automated release process with proper documentation

### 📦 Standalone Executable Features
- **Versioned Executable Names**: `sql2excel-v1.2.4.exe` format for clear version identification
- **Asset Bundling**: Excel templates and style files bundled within executable
- **Path Resolution**: Smart path resolution for packaged vs development environments
- **No Node.js Dependency**: Fully self-contained executable for end users

### 🌐 Multi-language Support
- **Korean Release Package**: `sql2excel-v1.2.4-ko` with Korean documentation and interface
- **English Release Package**: `sql2excel-v1.2.4-en` with English documentation and interface
- **Localized Batch Files**: Language-specific batch interfaces (`sql2excel.bat`, `sql2excel-en.bat`)
- **Automated Documentation**: Dynamic version replacement in user manuals and README files

### 🕒 Enhanced DateTime System
- **20+ DateTime Variables**: Comprehensive set of datetime functions for various formats
- **Real-time Generation**: Each function generates current timestamp at execution time
- **Multiple Formats**: UTC, KST, Korean localized, ISO, compact formats
- **Variable Processing Order**: Fixed processing order to ensure datetime variables work correctly

#### Available DateTime Variables
```javascript
CURRENT_TIMESTAMP    // 2025-10-05 14:30:25
KST_NOW             // 2025-10-05 23:30:25 (Korea Standard Time)
CURRENT_DATE        // 2025-10-05
CURRENT_TIME        // 14:30:25
KOREAN_DATE         // 2025년 10월 05일
KOREAN_DATETIME     // 2025년 10월 05일 14시 30분 25초
DATE_YYYYMMDD       // 20251005
DATETIME_YYYYMMDD_HHMMSS // 20251005_143025
ISO_TIMESTAMP       // 2025-10-05T14:30:25.123Z
UNIX_TIMESTAMP      // 1728134225
// ... and 10 more formats
```

### 📋 Table of Contents Enhancements
- **SQL Formatting Preservation**: Original SQL query formatting with line breaks maintained
- **Creation Timestamp**: Display file creation timestamp in each sheet
- **Improved Readability**: Better visual presentation of complex SQL queries

### 🔧 User Interface Improvements
- **Input Validation**: Automatic whitespace trimming for file paths in batch interface
- **Error Prevention**: Prevents "file not found" errors from accidental whitespace
- **Copy-Paste Friendly**: Handles paths copied from other sources with leading/trailing spaces

### 🚀 Build & Release System
- **Automated Release Script**: `npm run release` creates complete release packages
- **Version-aware Building**: `npm run build` generates versioned executable names
- **Documentation Sync**: Automatic version replacement in all documentation files
- **Clean Build Process**: `npm run clean` removes old builds and release files

### 🔧 Technical Improvements
- **Module Resolution Fix**: Resolved "Cannot find module" errors in packaged executables
- **Asset Path Management**: Dynamic asset path resolution for templates and styles
- **Variable Processing Logic**: Fixed datetime variable substitution order
- **Batch Script Robustness**: Improved file type detection and error handling

### 📚 Documentation Updates
- **User Manual Enhancement**: Updated with all new features and standalone executable usage
- **Release Documentation**: Comprehensive deployment and usage instructions
- **Example Updates**: Added datetime variable examples and multi-line SQL formatting

### 🐛 Bug Fixes
- **DateTime Variable Output**: Fixed issue where datetime values were not displaying in Excel sheets
- **Variable Processing Order**: Corrected variable substitution sequence to prioritize datetime functions
- **XML Structure Validation**: Fixed missing `<sheets>` tags in example files
- **Batch File Type Detection**: Improved XML/JSON file type identification in Windows batch interface
- **Path Resolution**: Fixed template file paths in packaged executable environment

---

## v1.2.3 - Parameter Override Feature Addition (2025-08-29)

### ✨ New Features
- **⚙️ Parameter Override Feature**: Override query definition parameters for each sheet
- **🔄 Enhanced Query Reuse**: Use the same query definition across multiple sheets with different parameters
- **📊 Priority System**: Process in order: sheet-specific parameters > global variables > default values
- **🎯 Multiple Data Type Support**: Support for string, number, array, boolean, and date parameter types
- **📝 Detailed Logging**: Comprehensive logging output for parameter override process

### 📊 Parameter Override System

#### Parameter Override in XML
```xml
<queryDefs>
  <queryDef id="customer_base" description="Base customer query">
    <![CDATA[
      SELECT CustomerID, CustomerName, Email, Phone, Region
      FROM Customers 
      WHERE IsActive = 1 
        AND Region IN (${regionList})
        AND CreatedDate >= '${startDate}'
    ]]>
  </queryDef>
</queryDefs>

<sheets>
  <!-- Seoul customers -->
  <sheet name="SeoulCustomers" use="true" queryRef="customer_base">
    <params>
      <param name="regionList">["Seoul"]</param>
      <param name="startDate">2024-01-01</param>
    </params>
  </sheet>
  
  <!-- Busan customers -->
  <sheet name="BusanCustomers" use="true" queryRef="customer_base">
    <params>
      <param name="regionList">["Busan"]</param>
      <param name="startDate">2024-03-01</param>
    </params>
  </sheet>
</sheets>
```

#### Parameter Override in JSON
```json
{
  "queryDefs": {
    "customer_base": {
      "name": "customer_base",
      "description": "Base customer query",
      "query": "SELECT CustomerID, CustomerName, Email, Phone, Region FROM Customers WHERE IsActive = 1 AND Region IN (${regionList}) AND CreatedDate >= '${startDate}'"
    }
  },
  "sheets": [
    {
      "name": "SeoulCustomers",
      "use": true,
      "queryRef": "customer_base",
      "params": {
        "regionList": ["Seoul"],
        "startDate": "2024-01-01"
      }
    }
  ]
}
```

### 🔧 Improvements
- **Enhanced Variable Processing Logic**: Added sheet-specific parameter support to `substituteVars` method
- **Parser Improvements**: Parameter override functionality supported in both XML and JSON parsers
- **Type Safety**: Safe parsing and processing for various data types
- **Logging System**: Detailed logging output for parameter override process to support debugging

### 📚 Documentation
- **User Manual Update**: Added detailed parameter override feature description
- **Example File Updates**: Added parameter override examples
- **README Update**: Added parameter override to main feature list

---

## v1.2.2 - Dynamic Variables System Enhancement (2025-08-20)

### ✨ New Features
- **🔄 Dynamic Variables System**: Extract values from database in real-time for dynamic query generation
- **📊 2 Dynamic Variable Types**: Default type (`column_identified` behavior), `key_value_pairs` type support
- **🎯 Default Type Improvement**: Automatically processes as `column_identified` type when `type` attribute is omitted
- **🔗 Time Function Integration**: Use time functions like `CURRENT_TIMESTAMP`, `CURRENT_DATE` in dynamic variables
- **🌐 Environment Variable Support**: Use environment variables in dynamic variables
- **🐛 Debug Mode**: Detailed variable substitution logging with `DEBUG_VARIABLES=true` environment variable

### 🔄 Dynamic Variable Type Features

#### 1. Default Type (column_identified behavior)
- Default when `type` attribute is omitted
- Creates arrays for each column
- Access specific column values using `${variableName.columnName}` format
- Example: `${customerData.CustomerID}`, `${customerData.Region}`

#### 2. key_value_pairs Type
- Requires explicit `type="key_value_pairs"` specification
- Creates key-value pairs from first two columns
- Access key values using `${variableName.keyName}` format
- Example: `${productPrices.ProductID}`

### 📝 Usage Examples
```xml
<!-- Dynamic variable definitions -->
<dynamicVars>
  <!-- Default type: type attribute omitted -->
  <dynamicVar name="customerData" description="Customer data by column">
    <![CDATA[
      SELECT CustomerID, CustomerName, City, Region
      FROM Customers WHERE IsActive = 1
    ]]>
  </dynamicVar>
  
  <!-- key_value_pairs type: explicit specification -->
  <dynamicVar name="productPrices" type="key_value_pairs" description="Product price information">
    <![CDATA[
      SELECT ProductID, UnitPrice
      FROM Products WHERE Discontinued = 0
    ]]>
  </dynamicVar>
</dynamicVars>

<!-- Using dynamic variables -->
<sheet name="CustomerOrderAnalysis">
  <![CDATA[
    SELECT * FROM Orders 
    WHERE CustomerID IN (${customerData.CustomerID})
      AND Region IN (${customerData.Region})
      AND ProductID IN (${productPrices.ProductID})
  ]]>
</sheet>
```

### 🔧 Improvements
- **Default Type Simplification**: Automatically processes as `column_identified` type when `type` attribute is omitted, improving usability
- **Variable Substitution Priority**: Processes in order: dynamic variables > regular variables > time functions > environment variables
- **SQL Injection Prevention**: Proper escaping for all variable values
- **Enhanced Error Handling**: Replaces dynamic variables with empty arrays for safety when processing errors occur
- **Performance Optimization**: Dynamic variables executed once and cached for entire export

### 📚 Documentation
- **README.md Update**: Added dynamic variables feature introduction and examples
- **USER_MANUAL.md Expansion**: Added detailed dynamic variables usage and type descriptions
- **Example Files Added**: Created `queries-with-dynamic-variables.xml`, `queries-with-dynamic-variables.json`

---

## v1.2.1 - Documentation Improvements (2025-08-11)

### 📚 Documentation
- **📖 User Manual**: Added comprehensive `USER_MANUAL.md`
- **📋 Version History**: Added systematic `CHANGELOG.md`
- **🔧 Configuration Guide**: Detailed database connection and setup instructions
- **💡 Example Expansion**: Added various usage scenarios and example code

### 🔧 Improvements
- **Documentation Structure**: Systematic document organization with table of contents
- **Example Enhancement**: Detailed examples for actual usage scenarios
- **Troubleshooting Guide**: Common issues and solutions
- **Version History**: Systematic organization of all version changes

---

## v1.2.0 - Query Reuse and CLI Improvements (2024-08-07)

### ✨ New Features
- **🔄 Query Definition Reuse**: Define common queries with `queryDefs` and reuse across multiple sheets
- **🖥️ New CLI Interface**: Command-line tool via `excel-cli.js`
- **🪟 Windows Batch Files**: Convenient execution batch files for Windows users
- **✅ File Validation**: Query file format and structure validation tool
- **🔗 DB Connection Test**: Check connection status for all configured databases

### 📊 Query Reuse System
- **XML/JSON Support**: `queryDefs` functionality supported in both formats
- **Code Reuse**: Reference same query across multiple sheets using `queryRef`
```xml
<queryDefs>
  <queryDef id="customer_base" description="Base customer query">
    <![CDATA[
      SELECT CustomerID, CustomerName, Email, Phone
      FROM Customers WHERE IsActive = 1
    ]]>
  </queryDef>
</queryDefs>

<sheets>
  <sheet name="CustomerList" use="true">
    <queryRef ref="customer_base"/>
  </sheet>
  
  <sheet name="CustomerOrders" use="true">
    <![CDATA[
      SELECT o.*, c.CustomerName
      FROM Orders o
      INNER JOIN (${customer_base}) c ON o.CustomerID = c.CustomerID
    ]]>
  </sheet>
</sheets>
```

### 🖥️ CLI Commands
```bash
# Generate Excel file
node src/excel-cli.js export --xml ./queries/sample.xml

# Validate query file
node src/excel-cli.js validate --xml ./queries/sample.xml

# List databases
node src/excel-cli.js list-dbs

# Help
node src/excel-cli.js help
```

### 🪟 Windows Batch Files
- `실행하기.bat`: Interactive execution
- `export-xml.bat`: Direct XML export
- `export-json.bat`: Direct JSON export
- `validate.bat`: File validation
- `db-test.bat`: Database connection test

---

## v1.1.5 - Excel Styling Enhancements (2024-08-06)

### ✨ New Features
- **🎨 Advanced Excel Styling**: Comprehensive styling for headers and data areas
- **📊 Font Control**: Font name, size, color, bold, italic settings
- **🎨 Fill Control**: Background color and pattern settings
- **📏 Border Control**: Border style, color, and position settings
- **📐 Alignment Control**: Horizontal/vertical alignment and text wrapping

### 📝 Styling Examples
```xml
<excel db="sampleDB" output="output/StyledReport.xlsx">
  <header>
    <font name="Arial" size="12" color="FFFFFF" bold="true"/>
    <fill color="4F81BD" patternType="solid"/>
    <border>
      <top style="thin" color="000000"/>
      <bottom style="thin" color="000000"/>
    </border>
    <alignment horizontal="center" vertical="center"/>
  </header>
  
  <data>
    <font name="Arial" size="10"/>
    <border>
      <top style="thin" color="CCCCCC"/>
      <bottom style="thin" color="CCCCCC"/>
    </border>
  </data>
</excel>
```

---

## v1.1.4 - Aggregation and Table of Contents (2024-08-05)

### ✨ New Features
- **📊 Aggregation Features**: Automatic aggregation and display of counts by specified column values
- **📋 Auto Table of Contents**: Automatically generate table of contents sheet with hyperlinks
- **🔗 Hyperlink Support**: Clickable links between sheets
- **📈 Statistics Display**: Row counts and creation information

### 📝 Aggregation Example
```xml
<sheet name="SalesByRegion" use="true" aggregateColumn="Region">
  <![CDATA[
    SELECT Region, SUM(TotalAmount) as TotalSales, COUNT(*) as OrderCount
    FROM Orders o
    INNER JOIN Customers c ON o.CustomerID = c.CustomerID
    GROUP BY Region
  ]]>
</sheet>
```

### 📋 Table of Contents Features
- Sheet names as hyperlinks
- Row counts for each sheet
- Creation timestamp
- File information

---

## v1.1.3 - Multi-Database Support (2024-08-04)

### ✨ New Features
- **🔗 Multiple DB Connections**: Use different database connections for each sheet
- **📊 Database Selection**: Specify database per sheet
- **🔧 Connection Management**: Efficient connection pool management
- **📋 Connection Validation**: Validate all database connections

### 📝 Multi-DB Example
```xml
<excel db="defaultDB" output="output/MultiDBReport.xlsx">
  <!-- Default database settings -->
</excel>

<sheets>
  <sheet name="CustomerData" db="customerDB" use="true">
    <![CDATA[SELECT * FROM Customers]]>
  </sheet>
  
  <sheet name="OrderData" db="orderDB" use="true">
    <![CDATA[SELECT * FROM Orders]]>
  </sheet>
</sheets>
```

---

## v1.1.2 - Variable System Enhancement (2024-08-03)

### ✨ New Features
- **📝 Enhanced Variable System**: Improved variable substitution and validation
- **🔗 Time Functions**: Support for `CURRENT_TIMESTAMP`, `CURRENT_DATE`, `CURRENT_TIME`
- **🌐 Environment Variables**: Use system environment variables
- **✅ Variable Validation**: Validate variable definitions and usage

### 📝 Variable Examples
```xml
<vars>
  <var name="startDate">2024-01-01</var>
  <var name="endDate">2024-12-31</var>
  <var name="currentTime">${CURRENT_TIMESTAMP}</var>
  <var name="dbName">${DATABASE_NAME}</var>
</vars>

<sheet name="TimeBasedReport" use="true">
  <![CDATA[
    SELECT * FROM Orders 
    WHERE OrderDate BETWEEN '${startDate}' AND '${endDate}'
      AND CreatedAt <= '${currentTime}'
  ]]>
</sheet>
```

---

## v1.1.1 - Performance and Stability (2024-08-02)

### ✨ New Features
- **🚦 Query Limits**: Row count limiting for large data processing
- **📊 Memory Optimization**: Improved memory usage for large datasets
- **🔧 Error Handling**: Enhanced error handling and recovery
- **📋 Progress Reporting**: Real-time progress reporting for long operations

### 🔧 Improvements
- **Performance**: Optimized data processing for large result sets
- **Stability**: Improved error handling and recovery mechanisms
- **Memory**: Better memory management for large exports
- **Logging**: Enhanced logging and progress reporting

---

## v1.1.0 - Multi-Sheet Support (2024-08-01)

### ✨ New Features
- **📊 Multi-Sheet Support**: Save multiple SQL query results in separate sheets within one Excel file
- **📋 Sheet Management**: Individual sheet configuration and control
- **🎨 Sheet Styling**: Individual styling per sheet
- **📊 Data Organization**: Organized data presentation across multiple sheets

### 📝 Multi-Sheet Example
```xml
<sheets>
  <sheet name="CustomerList" use="true">
    <![CDATA[SELECT * FROM Customers]]>
  </sheet>
  
  <sheet name="OrderSummary" use="true">
    <![CDATA[
      SELECT CustomerID, COUNT(*) as OrderCount, SUM(TotalAmount) as TotalSales
      FROM Orders GROUP BY CustomerID
    ]]>
  </sheet>
  
  <sheet name="ProductCatalog" use="true">
    <![CDATA[SELECT * FROM Products WHERE Discontinued = 0]]>
  </sheet>
</sheets>
```

---

## v1.0.5 - Configuration Enhancements (2024-07-31)

### ✨ New Features
- **📄 JSON Support**: Full JSON configuration file support
- **🔧 Configuration Validation**: Comprehensive configuration validation
- **📋 Default Values**: Sensible default values for all settings
- **🔍 Error Reporting**: Detailed error reporting and suggestions

### 📝 JSON Configuration Example
```json
{
  "excel": {
    "db": "sampleDB",
    "output": "output/Report.xlsx"
  },
  "sheets": [
    {
      "name": "CustomerData",
      "use": true,
      "query": "SELECT * FROM Customers"
    }
  ]
}
```

---

## v1.0.4 - Database Connectivity (2024-07-30)

### ✨ New Features
- **🔗 SQL Server Support**: Full SQL Server database connectivity
- **🔧 Connection Configuration**: Flexible database connection configuration
- **📋 Connection Pooling**: Efficient connection pool management
- **🔍 Connection Validation**: Database connection validation and testing

### 📝 Database Configuration
```json
{
  "dbs": {
    "sampleDB": {
      "server": "localhost",
      "port": 1433,
      "database": "SampleDB",
      "user": "sa",
      "password": "password",
      "options": {
        "encrypt": false,
        "trustServerCertificate": true
      }
    }
  }
}
```

---

## v1.0.3 - Core Excel Generation (2024-07-29)

### ✨ New Features
- **📊 Excel File Generation**: Core Excel file creation functionality
- **📋 Data Export**: SQL query results to Excel format
- **🎨 Basic Styling**: Basic Excel styling and formatting
- **📄 Multiple Formats**: Support for .xlsx format

### 🔧 Core Features
- SQL query execution
- Data extraction and formatting
- Excel file creation
- Basic styling application

---

## v1.0.2 - Project Foundation (2024-07-28)

### ✨ New Features
- **🏗️ Project Structure**: Initial project structure and organization
- **📦 Dependencies**: Core Node.js dependencies and packages
- **🔧 Configuration**: Basic configuration system
- **📚 Documentation**: Initial project documentation

### 📋 Foundation
- Node.js project setup
- Package.json configuration
- Basic file structure
- Initial documentation

---

## v1.0.1 - Initial Release (2024-07-27)

### ✨ New Features
- **🎯 Core Functionality**: Basic SQL to Excel conversion functionality
- **🔗 Database Support**: SQL Server database connectivity
- **📊 Data Export**: Export SQL query results to Excel
- **🖥️ Command Line**: Basic command-line interface

### 📋 Initial Features
- Basic SQL query execution
- Excel file generation
- Simple data export
- Command-line interface

---

**Contact**: sql2excel.nodejs@gmail.com  
**Website**: sql2excel.com  
**License**: MIT License
