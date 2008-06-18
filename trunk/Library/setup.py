#!/usr/bin/python

from distutils.core 	 import setup,Extension
from distutils.sysconfig import get_python_inc
from os		 			 import listdir,getcwd,path
#incdir = get_python_inc(plat_specific=1)
#print incdir

#build the list of Source files

global sourceFiles, currentWDir

dirFiles 	= ("../Core", "../NewerFunctionality", "../../SQLite/trunk","Link")
sourceFiles = []
currentWDir	= getcwd()


for aDir in dirFiles:
	if len (sourceFiles):
		sourceFiles.extend([path.normpath(path.join(currentWDir,aDir,aPath)) for aPath in listdir (aDir) if (aPath.endswith ('cpp') or aPath.endswith ('c'))])
	else:
		sourceFiles = [path.normpath(path.join(currentWDir,aDir,aPath)) for aPath in listdir (aDir) if (aPath.endswith ('cpp') or aPath.endswith ('c'))]
		
sourceFiles.append (path.normpath(path.join(currentWDir,"../Mains/hyphyunixutils.cpp")))
sourceFiles.append (path.normpath(path.join(currentWDir,"SWIGWrappers/THyPhy_python.cpp")))

setup(name='HyPhy',
      version='0.1',
      description		='HyPhy package interface library',
      author			='Sergei L Kosakovsky Pond',
      author_email		='spond@ucsd.edu',
      url				='http://www.hyphy.org/',
      package_dir 		={'': 'LibraryModules/Python'},
      packages			=['HyPhy','_Hyphy'],
      py_modules 		=['HyPhy.py'],
      ext_modules		= [Extension('_HyPhy', 
      		sourceFiles,
      		include_dirs 	= dirFiles,
      		define_macros	= [('SQLITE_PTR_SIZE','sizeof(long)'),
      						   ('__UNIX__',''),
      						   ('__MP__',''),
      						   ('__MP2__',''),
      						   ('__HEADLESS__','')],
      		libraries = ['pthread','ssl','crypto','curl'],
      		extra_compile_args = ['-w','-c', '-fsigned-char', '-O3', '-fpermissive', '-fPIC']
      	)]
     )