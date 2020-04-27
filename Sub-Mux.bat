@echo off
echo ----------------------------------------------------------------------
echo   Auto-mux script for softsub
echo   version 2.0 by tuilakhanh
::ver2
::support ?tf font extension
::donot process with the second raw
echo ----------------------------------------------------------------------
echo.
set videofileformat=m2ts mp4 mkv avi ts wmv flv flv mpeg mpeg 3gp webm vob ogv ogg drc gif gifv mng mov qt yuv rm rmvb asf m4p m4v mpg mp2 mpe mpv mpg m2v m4v svi 3g2 mxf roq nsv flv f4v f4p f4a f4b olshiro ket korin
::set videofileformat=mkv
::set subtitlefileformat=ass srt ssa pgs
set subtitlefileformat=ass
set ISOlanguage=vie
set subtitledefault=0:yes


Setlocal EnableDelayedExpansion
if exist "C:\Program Files\MKVToolNix\mkvmerge.exe" set mkvmergepath=C:\Program Files\MKVToolNix\mkvmerge.exe&goto:CONTINUE2
if exist "C:\Program Files (x86)\MKVToolNix\mkvmerge.exe" set mkvmergepath=C:\Program Files (x86)\MKVToolNix\mkvmerge.exe&goto:CONTINUE2
if not exist "C:\Program Files (x86)\MKVToolNix\mkvmerge.exe" echo Please install MKVToolNix first!&goto:CONTINUE3
:CONTINUE2

::limit of ep
set taplimit=400
for /l %%A IN (0,1,!taplimit!) do (
 set issuccess=false
 ::Add 0 for less ep 10
 set count=%%A
 if %%A LSS 10 set count=0%%A
 
 ::With each sub
 for %%B IN ("*- !count!*.%subtitlefileformat%") do (
  if not "!issuccess!"=="true" (
   ::With each video extension
   for %%Z IN (%videofileformat%) do (
    if not "!issuccess!"=="true" (
     ::Search video
     for %%C IN ("*- !count!*.%%Z") do (
      if not "!issuccess!"=="true" (
       
       ::Print sub, video name
       echo  -----------------------------------------------
       echo  Episode !count!
       echo   Output: %%~nB.mkv
       echo   Raw: %%~C
       echo   Sub: %%~B
       
       ::Collect Font, use all .tff
       set fontstring=
       for %%E IN (".\Font\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       for %%E IN (".\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       
       ::Collect Chapter, just use one chapter
       set chapterstring=
       set chapterfile=
       for %%G IN ("*- !count!*.txt") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       for %%G IN ("*- !count!*.xml") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       
       ::execute muxing
       echo.
       "!mkvmergepath!" -o "%%~nC.mkv" -S "%%~C" --forced-track "%subtitledefault%" --default-track "%subtitledefault%" --language "0:%ISOlanguage%" "%%~B" !fontstring! !chapterstring!
       echo.
       
       ::Delete sub raw chapter
       del "%%~nxB"
       del "%%~nxC"
       del ".\!chapterfile!"
       ::Success first video
       set issuccess=true
      )
     )
    )
   )
  )
 )
)

::OVA
for /l %%A IN (0,1,!taplimit!) do (
 set issuccess=false
 ::Add 0 for less ep 10
 set count=%%A
 
 ::With each sub
 for %%B IN ("*- OVA!count!*.%subtitlefileformat%") do (
  if not "!issuccess!"=="true" (
   ::With each video extension
   for %%Z IN (%videofileformat%) do (
    if not "!issuccess!"=="true" (
     ::Search video
     for %%C IN ("*- OVA!count!*.%%Z") do (
      if not "!issuccess!"=="true" (
       
       ::Print sub, video name
       echo  -----------------------------------------------
       echo  Episode OVA!count!
       echo   Output: %%~nB.mkv
       echo   Raw: %%~C
       echo   Sub: %%~B
       
       ::Collect Font, use all .tff
       set fontstring=
       for %%E IN (".\Font\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       for %%E IN (".\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       
       ::Collect Chapter, just use one chapter
       set chapterstring=
       set chapterfile=
       for %%G IN ("*- OVA!count!*.txt") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       for %%G IN ("*- OVA!count!*.xml") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       
       ::execute muxing
       echo.
       "!mkvmergepath!" -o "%%~nC.mkv" -S "%%~C" --forced-track "%subtitledefault%" --default-track "%subtitledefault%" --language "0:%ISOlanguage%" "%%~B" !fontstring! !chapterstring!
       echo.
       
       ::Delete sub raw chapter
       del "%%~nxB"
       del "%%~nxC"
       del ".\!chapterfile!"
       ::Success first video
       set issuccess=true
      )
     )
    )
   )
  )
 )
)

::OVA
for /l %%A IN (0,1,!taplimit!) do (
 set issuccess=false
 ::Add 0 for less ep 10
 set count=%%A
 
 ::With only one
 for %%B IN ("*- OVA*.%subtitlefileformat%") do (
  if not "!issuccess!"=="true" (
   ::With each video extension
   for %%Z IN (%videofileformat%) do (
    if not "!issuccess!"=="true" (
     ::Search video
     for %%C IN ("*- OVA*.%%Z") do (
      if not "!issuccess!"=="true" (
       
       ::Print sub, video name
       echo  -----------------------------------------------
       echo  Episode OVA
       echo   Output: %%~nB.mkv
       echo   Raw: %%~C
       echo   Sub: %%~B
       
       ::Collect Font, use all .tff
       set fontstring=
       for %%E IN (".\Font\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       for %%E IN (".\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       
       ::Collect Chapter, just use one chapter
       set chapterstring=
       set chapterfile=
       for %%G IN ("*- OVA*.txt") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       for %%G IN ("*- OVA*.xml") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       
       ::execute muxing
       echo.
       "!mkvmergepath!" -o "%%~nC.mkv" -S "%%~C" --forced-track "%subtitledefault%" --default-track "%subtitledefault%" --language "0:%ISOlanguage%" "%%~B" !fontstring! !chapterstring!
       echo.
       
       ::Delete sub raw chapter
       del "%%~nxB"
       del "%%~nxC"
       del ".\!chapterfile!"
       ::Success first video
       set issuccess=true
      )
     )
    )
   )
  )
 )
)

::OAD
for /l %%A IN (0,1,!taplimit!) do (
 set issuccess=false
 ::Add 0 for less ep 10
 set count=%%A
 
 ::With each sub
 for %%B IN ("*- OAD!count!*.%subtitlefileformat%") do (
  if not "!issuccess!"=="true" (
   ::With each video extension
   for %%Z IN (%videofileformat%) do (
    if not "!issuccess!"=="true" (
     ::Search video
     for %%C IN ("*- OAD!count!*.%%Z") do (
      if not "!issuccess!"=="true" (
       
       ::Print sub, video name
       echo  -----------------------------------------------
       echo  Episode OAD!count!
       echo   Output: %%~nB.mkv
       echo   Raw: %%~C
       echo   Sub: %%~B
       
       ::Collect Font, use all .tff
       set fontstring=
       for %%E IN (".\Font\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       for %%E IN (".\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       
       ::Collect Chapter, just use one chapter
       set chapterstring=
       set chapterfile=
       for %%G IN ("*- OAD!count!*.txt") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       for %%G IN ("*- OAD!count!*.xml") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       
       ::execute muxing
       echo.
       "!mkvmergepath!" -o "%%~nC.mkv" -S "%%~C" --forced-track "%subtitledefault%" --default-track "%subtitledefault%" --language "0:%ISOlanguage%" "%%~B" !fontstring! !chapterstring!
       echo.
       
       ::Delete sub raw chapter
       del "%%~nxB"
       del "%%~nxC"
       del ".\!chapterfile!"
       ::Success first video
       set issuccess=true
      )
     )
    )
   )
  )
 )
)

::OAD
for /l %%A IN (0,1,!taplimit!) do (
 set issuccess=false
 ::Add 0 for less ep 10
 set count=%%A
 
 ::With only one
 for %%B IN ("*- OAD*.%subtitlefileformat%") do (
  if not "!issuccess!"=="true" (
   ::With each video extension
   for %%Z IN (%videofileformat%) do (
    if not "!issuccess!"=="true" (
     ::Search video
     for %%C IN ("*- OAD*.%%Z") do (
      if not "!issuccess!"=="true" (
       
       ::Print sub, video name
       echo  -----------------------------------------------
       echo  Episode OAD
       echo   Output: %%~nB.mkv
       echo   Raw: %%~C
       echo   Sub: %%~B
       
       ::Collect Font, use all .tff
       set fontstring=
       for %%E IN (".\Font\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       for %%E IN (".\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       
       ::Collect Chapter, just use one chapter
       set chapterstring=
       set chapterfile=
       for %%G IN ("*- OAD*.txt") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       for %%G IN ("*- OAD*.xml") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       
       ::execute muxing
       echo.
       "!mkvmergepath!" -o "%%~nC.mkv" -S "%%~C" --forced-track "%subtitledefault%" --default-track "%subtitledefault%" --language "0:%ISOlanguage%" "%%~B" !fontstring! !chapterstring!
       echo.
       
       ::Delete sub raw chapter
       del "%%~nxB"
       del "%%~nxC"
       del ".\!chapterfile!"
       ::Success first video
       set issuccess=true
      )
     )
    )
   )
  )
 )
)

::SP
for /l %%A IN (0,1,!taplimit!) do (
 set issuccess=false
 ::Add 0 for less ep 10
 set count=%%A
 
 ::With each sub
 for %%B IN ("*- SP!count!*.%subtitlefileformat%") do (
  if not "!issuccess!"=="true" (
   ::With each video extension
   for %%Z IN (%videofileformat%) do (
    if not "!issuccess!"=="true" (
     ::Search video
     for %%C IN ("*- SP!count!*.%%Z") do (
      if not "!issuccess!"=="true" (
       
       ::Print sub, video name
       echo  -----------------------------------------------
       echo  Episode SP!count!
       echo   Output: %%~nB.mkv
       echo   Raw: %%~C
       echo   Sub: %%~B
       
       ::Collect Font, use all .tff
       set fontstring=
       for %%E IN (".\Font\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       for %%E IN (".\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       
       ::Collect Chapter, just use one chapter
       set chapterstring=
       set chapterfile=
       for %%G IN ("*- SP!count!*.txt") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       for %%G IN ("*- SP!count!*.xml") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       
       ::execute muxing
       echo.
       "!mkvmergepath!" -o "%%~nC.mkv" -S "%%~C" --forced-track "%subtitledefault%" --default-track "%subtitledefault%" --language "0:%ISOlanguage%" "%%~B" !fontstring! !chapterstring!
       echo.
       
       ::Delete sub raw chapter
       del "%%~nxB"
       del "%%~nxC"
       del ".\!chapterfile!"
       ::Success first video
       set issuccess=true
      )
     )
    )
   )
  )
 )
)

::SP
for /l %%A IN (0,1,!taplimit!) do (
 set issuccess=false
 ::Add 0 for less ep 10
 set count=%%A
 
 ::With only one
 for %%B IN ("*- SP*.%subtitlefileformat%") do (
  if not "!issuccess!"=="true" (
   ::With each video extension
   for %%Z IN (%videofileformat%) do (
    if not "!issuccess!"=="true" (
     ::Search video
     for %%C IN ("*- SP*.%%Z") do (
      if not "!issuccess!"=="true" (
       
       ::Print sub, video name
       echo  -----------------------------------------------
       echo  Episode SP
       echo   Output: %%~nB.mkv
       echo   Raw: %%~C
       echo   Sub: %%~B
       
       ::Collect Font, use all .tff
       set fontstring=
       for %%E IN (".\Font\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       for %%E IN (".\*.?tf") do (
        set fontstring=!fontstring! --attachment-name "%%~nxE" --attachment-mime-type application/x-truetype-font --attach-file "%%E"
        echo     Font: %%~nxE
       )
       
       ::Collect Chapter, just use one chapter
       set chapterstring=
       set chapterfile=
       for %%G IN ("*- SP*.txt") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       for %%G IN ("*- SP*.xml") do (
        set chapterstring=--chapter-language vie --chapters "%%~G"
        set chapterfile=%%G
        echo     Chapter: %%~G
       )
       
       ::execute muxing
       echo.
       "!mkvmergepath!" -o "%%~nC.mkv" -S "%%~C" --forced-track "%subtitledefault%" --default-track "%subtitledefault%" --language "0:%ISOlanguage%" "%%~B" !fontstring! !chapterstring!
       echo.
       
       ::Delete sub raw chapter
       del "%%~nxB"
       del "%%~nxC"
       del ".\!chapterfile!"
       ::Success first video
       set issuccess=true
      )
     )
    )
   )
  )
 )
)

@echo off
:CONTINUE3
echo.
echo ----------------------------------------------------------------------
echo Finished! Thank you for using!
echo Press any key to exit
pause > nul
cls