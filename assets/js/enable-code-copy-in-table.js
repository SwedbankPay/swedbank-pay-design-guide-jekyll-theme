// Automatically add copy buttons to tables with 'enable-copy' class
// Adds a copy button next to every <code> element in the table
document.addEventListener('DOMContentLoaded', function() {
  // Find all tables with class enable-copy
  document.querySelectorAll('table.enable-copy').forEach(table => {
    // Find all <code> elements in the table
    const codeElements = table.querySelectorAll('td code');
    
    codeElements.forEach(codeElement => {
      const value = codeElement.textContent.trim();
      
      // Create copy button matching copy-button.html component
      const button = document.createElement('button');
      button.setAttribute('aria-describedby', 'tooltipCopy');
      button.className = 'code-view-copy tooltip';
      button.setAttribute('aria-label', 'Copy to clipboard');
      button.value = value;
      button.onclick = function() { 
        navigator.clipboard.writeText(this.value);
      };
      
      const icon = document.createElement('i');
      icon.className = 'at-clipboard small';
      icon.setAttribute('aria-hidden', 'true');
      
      const tooltip = document.createElement('div');
      tooltip.setAttribute('role', 'tooltip');
      tooltip.textContent = 'Copy to clipboard';
      
      button.appendChild(icon);
      button.appendChild(tooltip);
      
      // Add button after the code element
      const cell = codeElement.parentElement;
      cell.appendChild(document.createTextNode(' '));
      cell.appendChild(button);
    });
  });
});
