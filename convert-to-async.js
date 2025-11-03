#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

// Function to convert then/catch to async/await
function convertToAsyncAwait(content) {
  // Convert route handlers
  content = content.replace(
    /router\.(get|post|put|delete|patch)\([^)]+\)\s*,\s*\(req,\s*res\)\s*=>\s*{/g,
    (match) => {
      if (!match.includes('async')) {
        return match.replace('(req, res) => {', 'async (req, res) => {');
      }
      return match;
    }
  );

  // Convert service functions
  content = content.replace(
    /exports\.(\w+)\s*=\s*\([^)]*\)\s*=>\s*{/g,
    (match, funcName) => {
      if (!match.includes('async')) {
        return match.replace('=> {', 'async => {');
      }
      return match;
    }
  );

  // Convert .then() chains to await
  content = content.replace(
    /(\w+)\s*\.\s*then\s*\(\s*\(([^)]+)\)\s*=>\s*{([^}]*)}\s*\)\s*\.\s*catch\s*\(\s*\(([^)]+)\)\s*=>\s*{([^}]*)}\s*\)/g,
    (match, variable, thenParams, thenBody, catchParams, catchBody) => {
      const tryBody = `const ${variable} = await ${variable};\n${thenBody}`;
      return `try {\n${tryBody}\n} catch (${catchParams}) {\n${catchBody}\n}`;
    }
  );

  // Convert simple .then() calls
  content = content.replace(
    /(\w+)\s*\.\s*then\s*\(\s*\(([^)]+)\)\s*=>\s*([^)]+)\s*\)/g,
    (match, variable, params, returnValue) => {
      return `const ${variable} = await ${variable};`;
    }
  );

  // Convert return statements with .then()
  content = content.replace(
    /return\s+(\w+)\s*\.\s*then\s*\(\s*\(([^)]+)\)\s*=>\s*([^)]+)\s*\)/g,
    (match, variable, params, returnValue) => {
      return `const result = await ${variable};\nreturn ${returnValue}`;
    }
  );

  // Convert Promise.all().then()
  content = content.replace(
    /Promise\.all\(([^)]+)\)\.then\(\(([^)]+)\)\s*=>\s*{([^}]*)}\s*\)/g,
    (match, promiseArray, params, body) => {
      return `const ${params} = await Promise.all(${promiseArray});\n${body}`;
    }
  );

  // Convert Promise.allSettled().then()
  content = content.replace(
    /Promise\.allSettled\(([^)]+)\)\.then\(\(([^)]+)\)\s*=>\s*{([^}]*)}\s*\)/g,
    (match, promiseArray, params, body) => {
      return `const ${params} = await Promise.allSettled(${promiseArray});\n${body}`;
    }
  );

  // Convert new Promise with async/await
  content = content.replace(
    /return\s+new\s+Promise\s*\(\s*async\s*\(resolve,\s*reject\)\s*=>\s*{([^}]*)}\s*\)/g,
    (match, body) => {
      return `try {\n${body}\n} catch (err) {\nthrow err;\n}`;
    }
  );

  // Convert resolve() calls to return
  content = content.replace(/resolve\(([^)]+)\)/g, 'return $1');

  // Convert reject() calls to throw
  content = content.replace(/reject\(([^)]+)\)/g, 'throw $1');

  return content;
}

// Function to process a file
function processFile(filePath) {
  try {
    const content = fs.readFileSync(filePath, 'utf8');
    const convertedContent = convertToAsyncAwait(content);
    
    if (content !== convertedContent) {
      fs.writeFileSync(filePath, convertedContent);
      console.log(`✅ Converted: ${filePath}`);
    } else {
      console.log(`⏭️  No changes needed: ${filePath}`);
    }
  } catch (error) {
    console.error(`❌ Error processing ${filePath}:`, error.message);
  }
}

// Function to recursively find and process files
function processDirectory(dirPath) {
  const files = fs.readdirSync(dirPath);
  
  files.forEach(file => {
    const filePath = path.join(dirPath, file);
    const stat = fs.statSync(filePath);
    
    if (stat.isDirectory()) {
      processDirectory(filePath);
    } else if (file.endsWith('.js')) {
      processFile(filePath);
    }
  });
}

// Main execution
const backendPath = path.join(__dirname, 'backend', 'src');
console.log('🔄 Starting async/await conversion...');
processDirectory(backendPath);
console.log('✅ Conversion complete!');
