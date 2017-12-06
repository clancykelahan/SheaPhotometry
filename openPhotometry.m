function openPhotometry

    global state gh
    
    gh.PhotometryMainGUI = guihandles(PhotometryMainGUI);
    
    openini('photometry.ini');