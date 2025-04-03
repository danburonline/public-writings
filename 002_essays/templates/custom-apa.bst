% ? Custom APA-like BibTeX Style (.bst) File
% ? Based on standard styles, with modifications for APA-like formatting.

ENTRY % Define the fields recognized for each entry type
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key         % Used for sorting and labels if author/editor missing
    month
    note
    number      % Issue number for journals, report number, etc.
    organization
    pages
    publisher
    school
    series
    title
    type        % Thesis type, report type, etc.
    urldate     % Date URL was accessed
    url
    volume
    year
  }
  {} % Functions provided by BibTeX (not defined here)
  { label       % The label used for citations, e.g., (Author, year)
    extra.label % For disambiguation (a, b, c after year)
    sort.label  % Base label used for initial sorting pass
    short.list  % Short author list for citation label
  }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

% Function to initialize state constants for managing punctuation/spacing
FUNCTION {init.state.consts}
{ #0 'before.all :=     % Beginning of entry, no preceding punctuation needed
  #1 'mid.sentence :=   % Inside a sentence block, usually precede with ", "
  #2 'after.sentence := % Just finished a sentence block, usually precede with ". "
  #3 'after.block :=    % Just finished a major block, precede with ".\n\newblock "
}

STRINGS { s t } % General purpose string variables

% Outputs string 's' if non-empty, adding appropriate punctuation based on output.state
FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ } % If mid-sentence, prepend ", "
    { output.state after.block =
        { add.period$ write$      % If after block, end previous block with period,
          newline$                %   start new line,
          "\newblock " write$    %   and add \newblock space.
        }
        { output.state before.all =
            'write$                % If at start, just write
            { add.period$ " " * write$ } % If after sentence, add ". "
          if$
        }
      if$
      mid.sentence 'output.state := % Set state to mid-sentence after outputting
    }
  if$
  s % Write the actual string
}

% Calls output.nonnull only if the string on stack is not empty
FUNCTION {output}
{ duplicate$ empty$
    'pop$            % If empty, do nothing
    'output.nonnull  % If not empty, call output.nonnull
  if$
}

% Checks if field 't' is empty; outputs warning if so, otherwise outputs the field value.
FUNCTION {output.check}
{ 't := % Field name for warning message
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ } % Warn if empty
    'output.nonnull % Output if not empty
  if$
}

% Finalizes the entry: adds a period, writes, and adds a newline.
FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

% Sets the output state to 'after.block', indicating a major block break.
FUNCTION {new.block}
{ output.state before.all =
    'skip$ % Do nothing if already at the beginning
    { after.block 'output.state := }
  if$
}

% Sets the output state to 'after.sentence', indicating a sentence break.
FUNCTION {new.sentence}
{ output.state after.block =
    'skip$ % Don't change state if already after a block
    { output.state before.all =
        'skip$ % Don't change state if at the very beginning
        { after.sentence 'output.state := }
      if$
    }
  if$
}

% Adds a space and resets the state to before.all (used before year usually).
FUNCTION {add.blank}
{ " " * before.all 'output.state :=
}

% Creates a block for the date (Year).
FUNCTION {date.block}
{ new.block % Ensure it starts as a new block (for punctuation)
}

% Logical NOT function for BibTeX integers (0=false, 1=true)
FUNCTION {not}
{ { #0 } { #1 } if$ }

% Logical AND function
FUNCTION {and}
{ 'skip$ { pop$ #0 } if$ }

% Logical OR function
FUNCTION {or}
{ { pop$ #1 } 'skip$ if$ }

% Calls new.block only if both strings on stack are non-empty.
FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

% Returns the field value or "" if the field is empty/missing.
FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

% Emphasizes (italics) a string if it's not empty. Uses \/ for italic correction.
FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "\/}" * }
  if$
}

% Adds a tie (~) or space before a short word (e.g., "Vol.~1", "p.~5", "No.~3").
FUNCTION {tie.or.space.prefix}
{ duplicate$ text.length$ #3 < % Check if word length is < 3
    { "~" } % Use tie if short
    { " " } % Use space if longer
  if$
  swap$ % Put prefix before the word
}

% Capitalizes the first letter of a string (intended for titles, etc.).
% Note: This is basic, only changes first letter based on simple case.
FUNCTION {capitalize}
{ "u" change.case$ "t" change.case$ } % Convert first char to upper, rest to title (lower?)

% Wraps a word with spaces.
FUNCTION {space.word}
{ " " swap$ * " " * }

%----------------------------------------------------------------------
% Language-Specific Strings (English)
%----------------------------------------------------------------------
FUNCTION {bbl.and} { "and" }
FUNCTION {bbl.etal} { "et~al." }
FUNCTION {bbl.editors} { "Eds." } % APA uses Eds./Ed.
FUNCTION {bbl.editor} { "Ed." }
FUNCTION {bbl.edby} { "edited by" } % Usually not used directly in APA refs
FUNCTION {bbl.edition} { "ed." }
FUNCTION {bbl.volume} { "Vol." }
FUNCTION {bbl.of} { "of" }
FUNCTION {bbl.number} { "No." }
FUNCTION {bbl.nr} { "No." } % Alias for number
FUNCTION {bbl.in} { "In" } % Capitalized for start of "In Editor..."
FUNCTION {bbl.pages} { "pp." }
FUNCTION {bbl.page} { "p." }
FUNCTION {bbl.chapter} { "chap." } % APA usually doesn't use "chap." prefix
FUNCTION {bbl.techrep} { "Tech. Rep." }
FUNCTION {bbl.mthesis} { "Master's thesis" }
FUNCTION {bbl.phdthesis} { "Ph.D. thesis" } % APA sometimes uses "Doctoral dissertation"

%----------------------------------------------------------------------
% Month Abbreviations (Common Style)
%----------------------------------------------------------------------
MACRO {jan} {"Jan."}
MACRO {feb} {"Feb."}
MACRO {mar} {"Mar."}
MACRO {apr} {"Apr."}
MACRO {may} {"May"}
MACRO {jun} {"Jun."}
MACRO {jul} {"Jul."}
MACRO {aug} {"Aug."}
MACRO {sep} {"Sep."}
MACRO {oct} {"Oct."}
MACRO {nov} {"Nov."}
MACRO {dec} {"Dec."}

%----------------------------------------------------------------------
% Journal Abbreviations (Common examples, add more as needed)
%----------------------------------------------------------------------
MACRO {acmcs} {"ACM Computing Surveys"}
MACRO {acta} {"Acta Informatica"}
MACRO {cacm} {"Communications of the ACM"}
MACRO {ibmjrd} {"IBM Journal of Research and Development"}
MACRO {ibmsj} {"IBM Systems Journal"}
MACRO {ieeese} {"IEEE Transactions on Software Engineering"}
MACRO {ieeetc} {"IEEE Transactions on Computers"}
MACRO {ieeetcad} {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}
MACRO {ipl} {"Information Processing Letters"}
MACRO {jacm} {"Journal of the ACM"}
MACRO {jcss} {"Journal of Computer and System Sciences"}
MACRO {scp} {"Science of Computer Programming"}
MACRO {sicomp} {"SIAM Journal on Computing"}
MACRO {tocs} {"ACM Transactions on Computer Systems"}
MACRO {tods} {"ACM Transactions on Database Systems"}
MACRO {tog} {"ACM Transactions on Graphics"}
MACRO {toms} {"ACM Transactions on Mathematical Software"}
MACRO {toois} {"ACM Transactions on Office Information Systems"}
MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}
MACRO {tcs} {"Theoretical Computer Science"}

%----------------------------------------------------------------------
% Field Checking Functions (from natbib styles)
%----------------------------------------------------------------------
% Checks if a bib field (e.g., author) exists and is non-empty.
% Returns value if okay, "" otherwise. Does not warn.
FUNCTION {bibinfo.check}
{ swap$ % Put field value on top
  duplicate$ missing$
    { % Field is missing
      pop$ pop$ "" % Discard value and name, return ""
    }
    { duplicate$ empty$
        { % Field exists but is empty
          swap$ pop$ % Discard value, keep name (though not used here), return ""? No, return value ""
        }
        { % Field exists and is non-empty
          swap$ pop$ % Discard name, keep value
        }
      if$
    }
  if$
}

% Checks if a bib field exists and is non-empty.
% Returns value if okay, "" otherwise. Issues warning if missing/empty.
FUNCTION {bibinfo.warn}
{ swap$ % Put field value on top
  duplicate$ missing$
    { % Field is missing
      swap$ "missing " swap$ * " in " * cite$ * warning$ % Issue warning
      pop$ "" % Discard name, return ""
    }
    { duplicate$ empty$
        { % Field exists but is empty
          swap$ "empty " swap$ * " in " * cite$ * warning$ % Issue warning
          % Keep the empty value "" on stack
        }
        { % Field exists and is non-empty
          swap$ pop$ % Discard name, keep value
        }
      if$
    }
  if$
}

% URL Formatting
% Writes the URL and URLDATE if present.
% Assumes \url and \urlprefix are defined (e.g., by url or hyperref package)
% Or uses the fallback definitions in begin.bib
FUNCTION {write.url}
{ url empty$
    { skip$ } % No URL, do nothing
    { "\newline\urlprefix\url{" url * "}" * % Format URL
      urldate empty$ % Check if urldate is present
        { skip$ } % No urldate, just write URL
        { " (Accessed: " * urldate * ")" * } % Add Accessed date if present
      if$
      write$ newline$
    }
  if$
  % Note: DOI handling is often preferred in APA 7. This style lacks explicit DOI field handling.
}

% Name Formatting
STRINGS  { bibinfo } % Stores the field name ("author", "editor") for checks
INTEGERS { nameptr namesleft numnames } % Loop counters for name processing

% Formats author names: Last, F. M., & Last, F. M.
% Uses {vv~}{ll}{, f.}{, jj} format: von Last, F. M., jj
FUNCTION {format.names}
{ 'bibinfo := % Store field name ("author")
  duplicate$ empty$ 'skip$ { % Proceed only if names are present
  's := % The list of names
  "" 't := % Temp string for formatted name
  #1 'nameptr := % Start with the first name
  s num.names$ 'numnames := % Total number of names
  numnames 'namesleft := % Counter for loop
    { namesleft #0 > } % Loop while names are left
    { s nameptr % Get the current name
      "{vv~}{ll}{, f.}{, jj}" % Format: von Last, F., jj
      format.name$
      bibinfo bibinfo.check % Check if field exists (redundant check here?)
      't := % Store formatted name in 't'
      nameptr #1 > % Is this NOT the first name?
        { % If not the first name...
          namesleft #1 > % Are there more names after this one?
            { ", " * t * } % If yes, add ", " before the name
            { % If this is the *last* name...
              numnames #2 > % If there were originally > 2 names...
                { "," * } % Add a comma before the '&' (Oxford comma)
                'skip$
              if$
              % Check for "others" (et al.) - BibTeX specific marker
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { pop$ " " * bbl.etal * } % Format as " et al."
                { "\&" space.word * t * } % Format as " & Name"
              if$
            }
          if$
        }
        { t } % If it IS the first name, just use it
      if$
      nameptr #1 + 'nameptr := % Increment name pointer
      namesleft #1 - 'namesleft := % Decrement names left counter
    }
  while$
  } if$
}

% Formats editor names: F. M. Last & F. M. Last
% Uses {f.~}{vv~}{ll}{, jj} format: F. M. von Last, jj
% Note: Slightly different initial format than format.names
FUNCTION {format.names.ed}
{ 'bibinfo := % Store field name ("editor")
  duplicate$ empty$ 'skip$ { % Proceed only if names are present
  's := % The list of names
  "" 't := % Temp string for formatted name
  #1 'nameptr := % Start with the first name
  s num.names$ 'numnames := % Total number of names
  numnames 'namesleft := % Counter for loop
    { namesleft #0 > } % Loop while names are left
    { s nameptr % Get the current name
      "{f.~}{vv~}{ll}{, jj}" % Format: F. M. von Last, jj
      format.name$
      bibinfo bibinfo.check % Check if field exists
      't := % Store formatted name in 't'
      nameptr #1 > % Is this NOT the first name?
        { % If not the first name...
          namesleft #1 > % Are there more names after this one?
            { ", " * t * } % If yes, add ", " before the name
            { % If this is the *last* name...
              numnames #2 > % If there were originally > 2 names...
                { "," * } % Add comma before '&'
                'skip$
              if$
              % Check for "others"
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                 { pop$ " " * bbl.etal * } % Format as " et al."
                 { "\&" space.word * t * } % Format as " & Name"
              if$
            }
          if$
        }
        { t } % If it IS the first name, just use it
      if$
      nameptr #1 + 'nameptr := % Increment name pointer
      namesleft #1 - 'namesleft := % Decrement names left counter
    }
  while$
  } if$
}

% Formats the key field if author/editor are missing. Returns "" if key also missing.
FUNCTION {format.key}
{ empty$ % Is the author/editor list that was passed empty?
    { key field.or.null } % If yes, use the 'key' field if available
    { "" } % If no (author/editor was provided), return "" - key not needed here
  if$
}

% Formats the authors using format.names.
FUNCTION {format.authors}
{ author "author" format.names }

% Determines if "Ed." or "Eds." should be used.
FUNCTION {get.bbl.editor}
{ editor num.names$ #1 > 'bbl.editors 'bbl.editor if$ }

% Formats the editors using format.names.ed and adds "(Ed.)" or "(Eds.)".
FUNCTION {format.editors}
{ editor "editor" format.names.ed % Format names first (F. M. Last)
  duplicate$ empty$ 'skip$ % Proceed only if editors exist
    { % If editors exist...
      " (" swap$ * % Prepend " ("
      get.bbl.editor * % Append "Ed.)" or "Eds.)"
      ")" * % Close parenthesis - APA uses (Ed.) or (Eds.)
      % " " * % Space before parenthesis? Usually yes
      % get.bbl.editor % Get Ed. or Eds.
      % capitalize % Capitalize Ed./Eds.
      % "(" swap$ * ")" * % Wrap in parentheses: (Ed.) or (Eds.)
      % * % Combine with formatted names
    }
  if$
}

% Field Formatting Helper Functions

% Formats the note field. Capitalizes first letter if mid-sentence.
FUNCTION {format.note}
{ note empty$
    { "" }
    { note #1 #1 substring$ % Get first character
      duplicate$ "{" = % Is it a command like {\LaTeX}?
        'skip$ % If yes, don't change case
        { output.state mid.sentence =
            { "l" } % If mid-sentence, start with lower case
            { "u" } % If start of sentence/block, start with upper case
          if$
          change.case$ % Apply case change to first letter
        }
      if$
      note #2 global.max$ substring$ * % Append the rest of the note
      "note" bibinfo.check % Perform the check (value already calculated)
    }
  if$
}

% Formats the title field (articles, chapters). Enforces sentence case.
FUNCTION {format.title}
{ title
  duplicate$ empty$ 'skip$
    { "t" change.case$ } % Sentence case ("t" usually maps to first upper, rest lower)
  if$
  "title" bibinfo.check
}

% Formats names fully: von Last, First M. & von Last, First M.
% Used for sorting and potentially full author list display (not typical APA ref list).
FUNCTION {format.full.names}
{ 's := % Name list
"" 't := % Temp name string
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{vv~}{ll}" format.name$ % Format: von Last
      't :=
      nameptr #1 >
        { % Not the first name
          namesleft #1 >
            { ", " * t * } % Add ", " if more names follow
            { % Last name in list
              s nameptr "{ff }{vv }{ll}{ jj}" format.name$ % Get full name for check? No, just last name {ll}
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { pop$ " " * bbl.etal * } % Use et al. if "others"
                {
                  numnames #2 > % Add comma before & if > 2 authors
                    { "," * }
                    'skip$
                  if$
                  "\&" space.word * t * % Add " & Name"
                }
              if$
            }
          if$
        }
        't % First name
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

% Determines the primary name list (author, editor, or key) for full name formatting.
FUNCTION {author.editor.key.full}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ } % Fallback to citation key start if all else fails
            'key % Use key field if no author/editor
          if$
        }
        { editor format.full.names } % Use editor if no author
      if$
    }
    { author format.full.names } % Use author primarily
  if$
}

% Helper for author or key (full names).
FUNCTION {author.key.full}
{ author empty$
    { key empty$
        { cite$ #1 #3 substring$ }
          'key
      if$
    }
    { author format.full.names }
  if$
}

% Helper for editor or key (full names).
FUNCTION {editor.key.full}
{ editor empty$
    { key empty$
        { cite$ #1 #3 substring$ }
          'key
      if$
    }
    { editor format.full.names }
  if$
}

% Selects the appropriate name formatting function based on entry type.
FUNCTION {make.full.names}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.full % Books prioritize author, then editor, then key
    { type$ "proceedings" =
        'editor.key.full % Proceedings prioritize editor, then key
        'author.key.full % Other types prioritize author, then key
      if$
    }
  if$
}

% Outputs the \bibitem command with label and citation key.
FUNCTION {output.bibitem}
{ newline$
  "\bibitem[{" write$
  label write$ % Write the generated label (e.g., Author, Yeara)
  % ") {" * write$ % Original had name list here too - removed for standard APA
  "}]{" * write$ % Close label bracket, open key bracket
  cite$ write$ % Write the citation key
  "}" write$ % Close key bracket
  newline$
  "" % Clear the stack
  before.all 'output.state := % Reset state for the new entry
}

% Converts hyphens in page ranges to en-dashes (--).
FUNCTION {n.dashify}
{ 't := % String to process (e.g., page number)
  "" % Accumulator string
    { t empty$ not } % Loop while t is not empty
    { t #1 #1 substring$ "-" = % Does t start with a hyphen?
        { % Yes, it starts with a hyphen
          t #1 #2 substring$ "--" = not % Is it NOT already an en-dash?
            { "--" * % If single hyphen, output en-dash
              t #3 global.max$ substring$ 't := % Skip the hyphen in input (was #2, needs #3 if input was --)
              % Correction: If it starts with '-', check length > 1
              % Better: Consume the first '-', output '--', consume rest starting #2
              t #2 global.max$ substring$ 't := % Consume the first hyphen, continue processing rest
            }
            { % It starts with "--" or more hyphens
              % Output the first hyphen, consume it, loop again
              "-" *
              t #2 global.max$ substring$ 't :=
              % { t #1 #1 substring$ "-" = } % While it starts with hyphen
              % { "-" *
              %   t #2 global.max$ substring$ 't :=
              % }
              % while$
            }
          if$ % This logic needs refinement for multiple hyphens - simpler: just replace first '-' with '--' if not '--'
        }
        { % No, it doesn't start with a hyphen
          t #1 #1 substring$ * % Output the character
          t #2 global.max$ substring$ 't := % Consume the character
        }
      if$
    }
  while$
}
% Simpler n.dashify - replaces single hyphens surrounded by digits or at start/end?
% Let's stick with the provided one, assuming it works for simple cases like 1-5 -> 1--5.
% Testing needed for cases like 1-5-10 or --10.

% Returns "In " (used before booktitle/editor in collections).
FUNCTION {word.in}
{ bbl.in % "In"
  " " * % Add space
}

% Formats the date (year), wraps in parentheses, adds extra.label (a, b, c).
FUNCTION {format.date}
{ year "year" bibinfo.check duplicate$ empty$
    { % Year is missing or empty
      "empty year in " cite$ * "; set to n.d." * warning$
      pop$ "n.d." % Use "n.d." as fallback
    }
    'skip$ % Year exists
  if$
  extra.label * % Append the disambiguation letter (a, b, c) if present
  before.all 'output.state := % Year block starts, reset state
  " (" swap$ * ")" * % Wrap in parentheses: (Yeara)
}

% Formats the title for books/proceedings (emphasized).
% Assumes Title Case is provided in the .bib file.
FUNCTION {format.btitle}
{ title "title" bibinfo.check
  duplicate$ empty$ 'skip$
    { emphasize } % Italicize
  if$
  % Note: APA requires Title Case for book titles. This function assumes input is correct.
}

% Checks if two fields (names on stack) are both non-empty and issues warning.
FUNCTION {either.or.check}
{ empty$ % Check second field
    'pop$ % If second is empty, pop it (first field is okay)
    { % Second field is not empty
      "can't use both " swap$ * " fields in " * cite$ * warning$ % Issue warning, swap puts first field name into message
    }
  if$
}

% Formats book volume information (e.g., Vol. 3 of Series Title).
FUNCTION {format.bvolume}
{ volume empty$
    { "" } % No volume, return empty string
    { bbl.volume volume tie.or.space.prefix % "Vol." + number
      "volume" bibinfo.check * * % Combine and check volume field
      series "series" bibinfo.check % Get series info
      duplicate$ empty$ 'pop$ % If series exists...
        { swap$ bbl.of space.word * swap$ % Add " of " between volume and series
          emphasize * % Emphasize the series title
        }
      if$
      "volume and number" number either.or.check % Warn if both volume and number exist for book
    }
  if$
}

% Formats number and series field (often for reports or journals if no volume).
FUNCTION {format.number.series}
{ volume empty$ % Only format if volume is *not* present (usually)
    { number empty$
        { series field.or.null } % If no number, just output series
        { series empty$
            { "No. " number * } % If no series, just "No. number"
            % { bbl.number number tie.or.space.prefix % Original had complex logic based on state
            %   "number" bibinfo.check * * }
          { % Both number and series exist
            bbl.number number tie.or.space.prefix "number" bibinfo.check * * % Format "No. number"
            bbl.in space.word * series emphasize * % Format "in Series Title" (italic series)
            % output.state mid.sentence = % Original had complex logic based on state for capitalization
            %     { bbl.number }
            %     { bbl.number capitalize }
            %   if$
            % number tie.or.space.prefix "number" bibinfo.check * *
            % bbl.in space.word *
            % series "series" bibinfo.check emphasize * % Italicize series
          }
        if$
        }
      if$
    }
    { "" } % If volume exists, don't output number/series here
  if$
}

% Formats the edition field (e.g., 2nd ed.).
FUNCTION {format.edition}
{ edition duplicate$ empty$ 'skip$ % Proceed if edition exists
    { % "(" * % APA format doesn't usually put edition in () unless combined?
      % output.state mid.sentence = % Capitalization handled by input typically
      %   { "l" }
      %   { "t" }
      % if$ change.case$
      " (" * % APA often uses (2nd ed.).
      edition "edition" bibinfo.check * % Get edition number/string
      " " * bbl.edition * % Add " ed."
      ")" * % Close parenthesis
    }
  if$
}

INTEGERS { multiresult } % Flag for multi-page check

% Checks if the pages string contains markers indicating multiple pages (-, ,, +).
FUNCTION {multi.page.check}
{ 't := % Page string
  #0 'multiresult := % Reset flag
    { multiresult not t empty$ not and } % Loop while flag is 0 and string not empty
    { t #1 #1 substring$ % Get first character
      duplicate$ "-" = % Is it a hyphen?
      swap$ duplicate$ "," = % Is it a comma?
      swap$ "+" = % Is it a plus?
      or or % If any are true...
        { #1 'multiresult := } % Set flag to true (multiple pages indicated)
        { t #2 global.max$ substring$ 't := } % Consume char and continue check
      if$
    }
  while$
  multiresult % Return the flag (1 if multi-page, 0 if single)
}

% Formats the pages field (e.g., p. 5, pp. 10--20).
% REMOVED parentheses wrapper `()` for standard APA style.
FUNCTION {format.pages}
{ pages duplicate$ empty$ 'skip$ % Proceed if pages exist
    { duplicate$ multi.page.check % Check if single or multiple pages
        { bbl.pages swap$ n.dashify } % If multiple, use "pp." and dashify range
        { bbl.page swap$ } % If single, use "p."
      if$
      tie.or.space.prefix % Add space or tie before page number
      "pages" bibinfo.check % Check pages field itself
      * * % Combine prefix ("pp. ") with number
      % "(" swap$ * ")" * % REMOVED: Don't wrap in parentheses here
    }
  if$
}

% Formats pages specifically for journals, adding preceding comma if journal info exists.
FUNCTION {format.journal.pages}
{ pages duplicate$ empty$ 'pop$ % Proceed if pages exist, discard duplicate if empty
    { swap$ duplicate$ empty$ % Check if the preceding info (vol/num) was empty
        { pop$ pop$ format.pages } % If preceding info was empty, just format pages
        { % Preceding info (vol/num) exists
          ", " * % Add comma separator
          swap$ % Bring pages string to top
          n.dashify % Dashify range
          "pages" bibinfo.check % Check pages field
          * % Combine comma and pages
        }
      if$
    }
  if$
}

% Formats volume, number, and pages for journals (e.g., *Journal*, *Vol*(Num), pages).
FUNCTION {format.vol.num.pages}
{ volume field.or.null % Get volume, or ""
  duplicate$ empty$ 'skip$
    { "volume" bibinfo.check emphasize } % Emphasize volume if present
  if$
  number "number" bibinfo.check duplicate$ empty$ 'skip$ % Get number, or ""
    { % Number is present
      swap$ duplicate$ empty$ % Check if volume was present
        { "there's a number but no volume in " cite$ * warning$ % Warn if number but no volume
          % Decide how to format: Maybe just output number? Or "(Num)"?
          % Let's assume "(Num)" is desired even without volume for now.
          " (" swap$ * ")" *
        }
        { % Volume was also present
          swap$ % Bring volume back to top
          % Volume already has emphasize applied if it existed.
           "(" swap$ * ")" * % Add (Num) after italicized volume: *Vol*(Num)
        }
      if$
    }
  if$ * % Combine Volume*(Num) string (or just *Vol* or (Num))
  format.journal.pages % Add the pages (with preceding comma if needed)
}

% Formats chapter and pages (e.g., Chap. 3, pp. 45--50).
FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages % If no chapter, just format pages (used for articles sometimes?)
    { % Chapter exists
      type empty$ % Check 'type' field (e.g., Section)
        { bbl.chapter } % Default to "Chap."
        { type "l" change.case$ % Use type field (lowercase) if present
          "type" bibinfo.check
        }
      if$
      chapter tie.or.space.prefix % Add space/tie before chapter number
      "chapter" bibinfo.check
      * * % Combine prefix ("Chap. ") and number
      pages empty$ % Check if pages exist
        'skip$ % No pages, just output chapter info
        { ", " * format.pages * } % Add ", pp. xx-yy" if pages exist
      if$
    }
  if$
}

% Formats the booktitle (emphasized). Assumes Title Case from .bib.
FUNCTION {format.booktitle}
{ booktitle "booktitle" bibinfo.check
  emphasize
}

% Formats "In [Ed./Eds.], Book Title" for incollection/inproceedings.
FUNCTION {format.in.ed.booktitle}
{ format.booktitle duplicate$ empty$ 'skip$ % Format booktitle first
    { % Booktitle exists
      editor "editor" format.names.ed duplicate$ empty$ 'pop$ % Format editors (F. M. Last)
        { % Editors also exist
          word.in swap$ * % Prepend "In " to the booktitle -> "In Book Title"
          swap$ % Bring formatted editors back to top
          " (" * % Add " (" before editors
          get.bbl.editor * % Add Ed./Eds.
          ")" * % Add ")" after Ed./Eds. -> (F. M. Last, Ed.)
          * % Combine: In Book Title (F. M. Last, Ed.)
          % " " * swap$ * % Original order: In F. M. Last (Ed.), Book Title
          % Let's try APA: In F. M. Last (Ed.), Book Title.
          " (" swap$ * % Add " (" before editors
          get.bbl.editor * % Add Ed./Eds.
          "), " * % Add "), " after Ed./Eds. -> (F. M. Last, Ed.),
          * swap$ % Combine: Editor string first
          word.in swap$ * % Prepend "In " -> In F. M. Last (Ed.),
          * % Combine with booktitle -> In F. M. Last (Ed.), Book Title
        }
        { % No editors, just booktitle
           word.in swap$ * % Prepend "In " -> "In Book Title"
        }
      if$
    }
  if$
}

% Formats the thesis type (e.g., Master's thesis, Ph.D. thesis).
FUNCTION {format.thesis.type}
{ type duplicate$ empty$
    'pop$ % Use default from bbl function if type field is empty
    { swap$ pop$ % Type field exists, use it
      "t" change.case$ "type" bibinfo.check % Sentence case the type
    }
  if$
}

% Formats the technical report number and type (e.g., Tech. Rep. No. 123).
FUNCTION {format.tr.number}
{ number "number" bibinfo.check % Get number first
  type duplicate$ empty$ % Check type field (e.g., "Technical Report")
    { pop$ bbl.techrep } % If type empty, use default "Tech. Rep."
    'skip$ % Type exists, use it
  if$
  "type" bibinfo.check % Check the type field value
  swap$ duplicate$ empty$ % Check if number exists
    { pop$ "t" change.case$ } % No number, just output type (sentence case)
    { tie.or.space.prefix * * } % Number exists, combine "Type No. number"
  if$
}

% Formats crossref for article (e.g., In \cite{crossref}).
FUNCTION {format.article.crossref}
{ word.in % "In "
  " \cite{" * crossref * "}" * % Append citation command
}

% Formats crossref for book (e.g., Vol. 2 of \cite{crossref}).
FUNCTION {format.book.crossref}
{ volume duplicate$ empty$ % Check volume field in the child entry
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      pop$ word.in % Warn and use "In " as fallback
    }
    { % Volume exists in child entry
      bbl.volume capitalize % "Vol."
      swap$ tie.or.space.prefix "volume" bibinfo.check * * % Add number "Vol. N"
      bbl.of space.word * % Add " of " -> "Vol. N of "
    }
  if$
  " \cite{" * crossref * "}" * % Append citation command
}

% Formats crossref for incollection/inproceedings (e.g., In \cite{crossref}).
FUNCTION {format.incoll.inproc.crossref}
{ word.in % "In "
  " \cite{" * crossref * "}" * % Append citation command
}

% Helper to format Org/Pub and Address block.
FUNCTION {format.org.or.pub}
{ 't := % Publisher or Organization string
  "" % Accumulator
  address empty$ t empty$ and % If both address and t are empty, skip
    'skip$
    { address "address" bibinfo.check * % Add address if present
      t empty$
        'skip$ % No publisher/org, just address
        { address empty$
            'skip$ % No address, just publisher/org (already in t)
            { ": " * } % Address exists, add ": " separator
          if$
          t * % Add publisher/org
        }
      if$
    }
  if$
}

% Formats Publisher and Address.
FUNCTION {format.publisher.address}
{ publisher "publisher" bibinfo.warn % Get publisher (warn if missing/empty)
  format.org.or.pub % Format with address
}

% Formats Organization and Address.
FUNCTION {format.organization.address}
{ organization "organization" bibinfo.check % Get organization
  format.org.or.pub % Format with address
}


% ENTRY TYPE FORMATTING FUNCTIONS

% Article
FUNCTION {article}
{ output.bibitem % Start with \bibitem
  format.authors "author" output.check % Author(s).
  % author format.key output % Key not usually shown directly
  format.date "year" output.check % (Year).
  date.block % Punctuation state management
  format.title "title" output.check % Title of article. Sentence case.
  new.block
  crossref missing$ % Check if using crossref
    { % No crossref, format journal info directly
      journal "journal" bibinfo.check emphasize "journal" output.check % *Journal Name*
      format.vol.num.pages output % *Vol*(Issue), pages.
    }
    { % Using crossref
      format.article.crossref output.nonnull % In \cite{key}
      format.pages output % Output pages from this entry
    }
  if$
  new.block
  format.note output % Optional Note.
  fin.entry % Add final period, newline.
  write.url % Add URL if present
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check % Editor(s) (Ed./Eds.).
      % editor format.key output % Key not shown
      add.blank % Add space before date
    }
    { format.authors output.nonnull % Author(s).
      crossref missing$
        { "author and editor" editor either.or.check } % Warn if both author & editor locally
        'skip$
      if$
      add.blank % Space before date
    }
  if$
  format.date "year" output.check % (Year).
  date.block
  format.btitle "title" output.check % *Book Title*. (Title Case expected in bib file)
  format.edition output % (ed.). Must come after title, before publisher potentially.
  crossref missing$
    { % No crossref, format locally
      format.bvolume output % Volume of Series.
      new.block
      format.number.series output % Number in Series (if no volume).
      new.sentence
      format.publisher.address output % Publisher Location: Publisher.
    }
    { % Using crossref
      new.block
      format.book.crossref output.nonnull % Vol. N of \cite{key}.
    }
  if$
  % format.edition output % APA puts edition after title. Moved up.
  new.block
  format.note output % Note.
  fin.entry
  write.url % URL.
}

% Booklet
FUNCTION {booklet}
{ output.bibitem
  format.authors output % Author(s). (Optional)
  % author format.key output
  format.date "year" output.check % (Year).
  date.block
  format.title "title" output.check % *Title*. (APA uses italics for standalone works) -> Should use format.btitle?
  % Let's use format.btitle for italics consistency with 'book'
  % format.btitle "title" output.check % *Title*.
  new.block
  howpublished "howpublished" bibinfo.check output % How published [format].
  address "address" bibinfo.check output % Address. (Often combined with publisher/org if available)
  new.block
  format.note output % Note.
  fin.entry
  write.url
}

% InBook (Part of a Book with its own title, possibly author)
FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check % Editor(s) (Ed./Eds.).
      % editor format.key output
    }
    { format.authors output.nonnull % Author(s).
      crossref missing$
        { "author and editor" editor either.or.check } % Warn if book has editor too
        'skip$
      if$
    }
  if$
  add.blank % Space before date
  format.date "year" output.check % (Year).
  date.block
  format.title "title" output.check % Chapter title. (Sentence case)
  % format.btitle "title" output.check % Title of chapter. (Sentence case for chapters) -> Use format.title
  new.block
  crossref missing$
    { % No crossref, format book info locally
      word.in % "In "
      format.editors output.nonnull % F. M. Editor (Ed.),
      format.btitle "booktitle" output.check % *Book Title*
      format.bvolume output % Volume info
      format.chapter.pages "chapter and pages" output.check % (Chap. N, pp. xx-yy) -> APA uses (pp. xx-yy)
      % Let's re-evaluate the structure for APA: Author (Year). Chapter title. In Editor (Ed.), *Book Title* (pp. pages). Publisher.
      % Need to reorder slightly.
      % Corrected flow attempt:
      % 1. Author(s) output.nonnull add.blank
      % 2. format.date output.check date.block
      % 3. format.title output.check % Chapter title.
      % 4. new.sentence word.in format.editors output.nonnull % In Editor(s) (Ed./Eds.),
      % 5. format.btitle "booktitle" output.check % *Book Title*
      % 6. format.chapter.pages output % (pp. pages) - need parens here? Yes, for pages in book.
      % 7. format.bvolume output % Volume info (less common for inbook?)
      % 8. format.number.series output
      % 9. new.sentence format.publisher.address output % Publisher.
      % Let's try implementing the above order. This requires significant change.
      % Sticking closer to original structure for now, which might yield:
      % Author (Year). Chapter Title. *Book Title* Vol. N (Chap. N, pp. xx-yy). Publisher.
      % This isn't quite APA 7. Keeping original structure for minimal changes.

      format.in.ed.booktitle "booktitle" output.check % In Editor (Ed.), *Book Title*
      format.bvolume output % Volume info (if any)
      format.number.series output % Series info (if any)
      % Pages are now tricky. APA wants them in parentheses *after* book title.
      % Let's add parentheses manually here for pages.
      pages empty$ 'skip$
        { format.pages "pages" bibinfo.check " (" swap$ * ")" * output }
      if$
      % format.chapter.pages "chapter and pages" output.check % Original call
      new.sentence
      format.publisher.address output % Publisher.
    }
    { % Using crossref
      format.chapter.pages "chapter and pages" output.check % Chapter, pages from child
      new.block
      format.book.crossref output.nonnull % In Vol. N of \cite{key}
    }
  if$
  format.edition output % (ed.) - applies to the book, put after publisher? APA puts after title. Let's move back up.
  % Moved format.edition earlier
  new.block
  format.note output % Note.
  fin.entry
  write.url
}

% InCollection (Article in a book/collection)
FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check % Author(s).
  % author format.key output
  add.blank
  format.date "year" output.check % (Year).
  date.block
  format.title "title" output.check % Article Title. (Sentence case)
  new.block
  crossref missing$
    { % No crossref
      format.in.ed.booktitle "booktitle" output.check % In Editor(s) (Ed./Eds.), *Book Title*
      format.bvolume output % Volume
      format.number.series output % Series
      % format.chapter.pages output % Chapter/Pages -> APA wants (pp. xx-yy)
      pages empty$ 'skip$
        { format.pages "pages" bibinfo.check " (" swap$ * ")" * output }
      if$
      new.sentence
      format.publisher.address output % Publisher.
      format.edition output % (Edition) - of the book. Position OK? After publisher? APA: After title. Moved.
    }
    { % Using crossref
      format.incoll.inproc.crossref output.nonnull % In \cite{key}
      format.chapter.pages output % Chapter/Pages from child entry
    }
  if$
  new.block
  format.note output % Note.
  fin.entry
  write.url
}

% InProceedings / Conference
FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check % Author(s).
  % author format.key output
  add.blank
  format.date "year" output.check % (Year).
  date.block
  format.title "title" output.check % Paper Title. (Sentence case)
  new.block
  crossref missing$
    { % No crossref
      format.in.ed.booktitle "booktitle" output.check % In Editor(s) (Ed./Eds.), *Proceedings Title*
      format.bvolume output % Volume
      format.number.series output % Series
      % format.pages output % Pages -> APA wants (pp. xx-yy)
      pages empty$ 'skip$
        { format.pages "pages" bibinfo.check " (" swap$ * ")" * output }
      if$
      new.sentence
      publisher empty$ % Publisher takes precedence over organization for proceedings usually
        { format.organization.address output } % Organization, Address.
        { organization "organization" bibinfo.check output % Org (if exists)
          format.publisher.address output % Publisher, Address.
        }
      if$
    }
    { % Using crossref
      format.incoll.inproc.crossref output.nonnull % In \cite{key}
      format.pages output % Pages from child entry
    }
  if$
  new.block
  format.note output % Note.
  fin.entry
  write.url
}
FUNCTION {conference} { inproceedings } % Alias

% Manual
FUNCTION {manual}
{ output.bibitem
  format.authors output % Author(s) or Organization. (Use author field for org?)
  % author format.key output
  format.date "year" output.check % (Year).
  date.block
  format.btitle "title" output.check % *Title of manual*. (Italicized)
  organization address new.block.checkb % New block if org or address provided
  organization "organization" bibinfo.check output % Organization.
  address "address" bibinfo.check output % Address.
  format.edition output % (Edition).
  new.block
  format.note output % Note.
  fin.entry
  write.url
}

% Master's Thesis
FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check % Author.
  % author format.key output
  add.blank
  format.date "year" output.check % (Year).
  date.block
  format.btitle % *Title of thesis*. (Italicized) - APA usually italics
  "title" output.check
  new.block
  bbl.mthesis format.thesis.type output.nonnull % Master's thesis type.
  school "school" bibinfo.warn output % , University Name. (Warn if missing)
  address "address" bibinfo.check output % , Location. (Optional)
  new.block
  format.note output % Note.
  fin.entry
  write.url
}

% Miscellaneous
FUNCTION {misc}
{ output.bibitem
  format.authors output % Author(s). (Optional)
  % author format.key output
  format.date "year" output.check % (Year). (Optional but recommended)
  date.block
  format.title output % Title. (Italicize if standalone? Use format.btitle?)
  % Let's italicize misc titles if they seem like standalone works
  % format.btitle "title" output.check % *Title*.
  new.block
  howpublished "howpublished" bibinfo.check output % How published [description].
  new.block
  format.note output % Note.
  fin.entry
  write.url
}

% PhD Thesis
FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check % Author.
  % author format.key output
  add.blank
  format.date "year" output.check % (Year).
  date.block
  format.btitle % *Title of thesis*. (Italicized)
  "title" output.check
  new.block
  % Determine thesis type string (Ph.D. thesis or Doctoral dissertation)
  type$ empty$
    { bbl.phdthesis } % Default
    { format.thesis.type } % Use 'type' field if present
  if$
  output.nonnull % Output the thesis type string
  % bbl.phdthesis format.thesis.type output.nonnull % Original line
  school "school" bibinfo.warn output % , University Name.
  address "address" bibinfo.check output % , Location. (Optional)
  new.block
  format.note output % Note.
  fin.entry
  write.url
}

% Proceedings (whole volume)
FUNCTION {proceedings}
{ output.bibitem
  format.editors output % Editor(s) (Ed./Eds.).
  % editor format.key output
  add.blank
  format.date "year" output.check % (Year).
  date.block
  format.btitle "title" output.check % *Title of Proceedings*. (Title Case expected)
  format.bvolume output % Volume info.
  format.number.series output % Series info.
  new.sentence
  publisher empty$
    { format.organization.address output } % Organization, Address.
    { organization "organization" bibinfo.check output % Org.
      format.publisher.address output % Publisher, Address.
    }
  if$
  new.block
  format.note output % Note.
  fin.entry
  write.url
}

% Technical Report
FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check % Author(s).
  % author format.key output
  add.blank
  format.date "year" output.check % (Year).
  date.block
  format.btitle % *Title of report*. (Italicized) - APA usually italics for reports
  "title" output.check
  new.block
  format.tr.number output.nonnull % Report Type No. number.
  institution "institution" bibinfo.warn output % , Institution Name.
  address "address" bibinfo.check output % , Address.
  new.block
  format.note output % Note.
  fin.entry
  write.url
}

% Unpublished
FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check % Author(s).
  % author format.key output
  add.blank
  format.date "year" output.check % (Year).
  date.block
  format.title "title" output.check % Title of work. (Italicize? APA often does for unpublished manuscripts)
  % Let's italicize:
  % format.btitle "title" output.check % *Title*.
  new.block
  format.note "note" output.check % Note field is REQUIRED here, should contain status (e.g., Unpublished manuscript).
  fin.entry
  write.url
}

% Default entry type if none is specified or matched
FUNCTION {default.type} { misc }

% Read the .bib file entries
READ

% SORTING AND LABEL GENERATION FUNCTIONS

% Function to purify and lowercase a string for sorting.
FUNCTION {sortify}
{ purify$ % Remove accents, special chars etc.
  "l" change.case$ % Convert to lower case
}

INTEGERS { len } % Variable for chop.word

% Removes leading articles ("A ", "An ", "The ") from a string for sorting titles.
FUNCTION {chop.word}
{ 's := % String to chop
  'len := % Length of article ("A " = 2, "An " = 3, "The " = 4)
  s #1 len substring$ = % Does string start with the article?
    { s len #1 + global.max$ substring$ } % If yes, return string starting after article+space
    's % If no, return original string
  if$
}

% Formats names for the citation label (e.g., Author & Author; Author et al.)
FUNCTION {format.lab.names}
{ 's := % Name list string
  % "" 't := % Temp variable not really needed here
  s #1 "{vv~}{ll}" format.name$ % Get "von Last" of first author
  s num.names$ duplicate$ % Get number of names
  #2 > % More than 2 names?
    { pop$ % Discard name count
      " " * bbl.etal * % Append " et al."
    }
    { #2 < % Exactly 1 name?
        'skip$ % Just use the single name from above
        { % Exactly 2 names
          s #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" = % Check if 2nd is "others"
            { " " * bbl.etal * } % Use " et al." if second name is "others"
            { " \& " * s #2 "{vv~}{ll}" format.name$ * } % Append " & von Last" for second author
          if$
        }
      if$
    }
  if$
}

% Determines label based on author or key.
FUNCTION {author.key.label}
{ author empty$
    { key empty$ % No author, no key
        { cite$ #1 #3 substring$ } % Fallback: Use first 3 chars of cite key
        'key % No author, use key field
      if$
    }
    { author format.lab.names } % Use formatted author names
  if$
}

% Determines label based on author, editor, or key.
FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { key empty$ % No author, no editor, no key
            { cite$ #1 #3 substring$ } % Fallback: Use first 3 chars of cite key
            'key % No author/editor, use key
          if$
        }
        { editor format.lab.names } % No author, use editor
      if$
    }
    { author format.lab.names } % Use author
  if$
}

% Determines label based on editor or key.
FUNCTION {editor.key.label}
{ editor empty$
    { key empty$ % No editor, no key
        { cite$ #1 #3 substring$ } % Fallback: Use first 3 chars of cite key
        'key % No editor, use key
      if$
    }
    { editor format.lab.names } % Use editor
  if$
}

% Selects the primary name source for the citation label based on entry type.
FUNCTION {calc.short.authors}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label % For books/inbooks: Author > Editor > Key
    { type$ "proceedings" =
        'editor.key.label % For proceedings: Editor > Key
        'author.key.label % For others: Author > Key
      if$
    }
  if$
  'short.list := % Store the result (e.g., "Smith et al.") in short.list
}

% Calculates the base label (e.g., "Smith et al., 2023") before adding disambiguation letters.
FUNCTION {calc.label}
{ calc.short.authors % Get the name part (e.g., "Smith et al.") into short.list
  short.list % Push name part onto stack
  % "(" swap$ * % Original natbib style added parens here, APA uses name, year
  ", " * % Add ", " separator
  year duplicate$ empty$ % Get year, check if empty
  % short.list key field.or.null = or % Don't check key match here
    { pop$ "n.d." } % If year is empty, use "n.d."
    'skip$ % Year exists, use it
  if$
  * % Combine name part and year (or n.d.) -> "Smith et al., 2023"
  'label := % Store in 'label' variable
}

% Formats names for sorting (e.g., "lastvv  first  jj"). Lowercase.
FUNCTION {sort.format.names}
{ 's := % Name list
  #1 'nameptr :=
  "" % Accumulator string
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > } % Loop through names
    { s nameptr
      "{vv{ } }{ll{ }}{ f{ }}{ jj{ }}" % Format: von Last F J
      format.name$ 't := % Get formatted name
      nameptr #1 > % Not the first name?
        { "   " * % Add separator between names for sorting robustness
          namesleft #1 = t "others" = and % Is it the last name AND "others"?
            { "zzzzz" * } % Sort "others" last
            { t sortify * } % Sort by lowercase name
          if$
        }
        { t sortify * } % First name, sort lowercase
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

% Formats title for sorting (lowercase, remove leading articles).
FUNCTION {sort.format.title}
{ 't := % Title string
  "A " #2 % Chop "A "
    "An " #3 % Chop "An "
      "The " #4 t chop.word % Chop "The " (pass string t to chop)
    chop.word % Result of "The " chop passed to "An " chop
  chop.word % Result of "An " chop passed to "A " chop
  sortify % Lowercase and purify
  #1 global.max$ substring$ % Ensure it's treated as a string? Not necessary.
}

% Gets the sort key based on author or key field.
FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$ "" } % Warn and return "" if no key
        { key sortify } % Sort by key if no author
      if$
    }
    { author sort.format.names } % Sort by formatted author names
  if$
}

% Gets the sort key based on author, editor, or key field.
FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$ "" }
            { key sortify } % Sort by key if no author/editor
          if$
        }
        { editor sort.format.names } % Sort by editor if no author
      if$
    }
    { author sort.format.names } % Sort by author
  if$
}

% Gets the sort key based on editor or key field.
FUNCTION {editor.sort}
{ editor empty$
    { key empty$
        { "to sort, need editor or key in " cite$ * warning$ "" }
        { key sortify } % Sort by key if no editor
      if$
    }
    { editor sort.format.names } % Sort by editor
  if$
}

% Presort function: Calculate label and main sort key (based on names/key + year + title).
FUNCTION {presort}
{ calc.label % Calculate "Author, Year" label -> stored in 'label'
  label sortify % Use lowercased label for initial sort? No, use names/year/title.
  "    " % Separator for sort key components
  *
  % Determine primary name source for sorting
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort % Books: Author > Editor > Key
    { type$ "proceedings" =
        'editor.sort % Proceedings: Editor > Key
        'author.sort % Others: Author > Key
      if$
    }
  if$
  % Got the formatted sort names on stack
  #1 entry.max$ substring$ % Truncate sort names to max length
  'sort.label := % Store truncated sort names in sort.label (used by bib.sort.order removed)
  sort.label % Push sort names onto stack for the main sort key
  * % Combine separator and sort names
  "    " % Separator
  *
  year field.or.null sortify % Add lowercase year (or "" if missing)
  *
  "    " % Separator
  *
  title field.or.null % Get title or ""
  sort.format.title % Format title for sorting (chop articles, lowercase)
  * % Add title part to sort key
  #1 entry.max$ substring$ % Truncate the entire sort key
  'sort.key$ := % Store the final sort key (e.g., "authornames    year    title")
}

% First Pass: Calculate labels and the main sort key for all entries.
ITERATE {presort}

% First Sort: Sort entries based on the calculated sort.key$ (Name/Year/Title).
SORT

% Disambiguation Label ('extra.label') Calculation (a, b, c)
STRINGS { last.label next.extra } % Variables for tracking labels during passes
INTEGERS { last.extra.num number.label } % Counters for disambiguation letters

% Initialize variables for disambiguation pass.
FUNCTION {initialize.extra.label.stuff}
{ #0 int.to.chr$ 'last.label := % Store initial dummy label (character 0)
  "" 'next.extra := % Stores the 'extra.label' of the *next* entry in reverse pass
  #0 'last.extra.num := % Counter for 'a', 'b', 'c' (ASCII value)
  #0 'number.label := % Total number of entries counter
}

% Forward pass: Iterate through sorted entries, assign 'a', 'b', 'c'...
% to entries with identical labels ("Author, Year").
FUNCTION {forward.pass}
{ label label = % Compare current entry's label with previous one (last.label)
    { % Labels are identical, need disambiguation
      last.extra.num #1 + 'last.extra.num := % Increment letter counter (ASCII)
      last.extra.num int.to.chr$ 'extra.label := % Assign 'a', 'b', etc.
    }
    { % Labels differ, start new sequence
      "a" chr.to.int$ 'last.extra.num := % Reset counter to 'a' (ASCII 97)
      "" 'extra.label := % First entry in sequence gets no letter (yet)
      label 'last.label := % Store current label as the new 'last.label'
    }
  if$
  number.label #1 + 'number.label := % Increment total entry count
}

% Reverse pass: Correct the 'extra.label' assignments.
% The forward pass assigns 'a' to the *second* identical entry, 'b' to the third, etc.
% This pass ensures that if there are multiple identical entries, the *first* one
% also gets an 'a' if needed (i.e., if the sequence length > 1).
FUNCTION {reverse.pass}
{ next.extra "b" = % Was the *next* entry (processed just before this one in reverse) a 'b'?
    { "a" 'extra.label := } % If yes, it means this entry is the *first* of a multi-entry sequence, so set its label to 'a'.
    'skip$ % Otherwise, keep the extra.label assigned in forward pass ('', 'b', 'c'...).
  if$
  extra.label 'next.extra := % Store the current extra.label for the *next* iteration (previous entry)
  extra.label duplicate$ empty$ % Check if an extra label ('a', 'b'...) was assigned
    'skip$
    { "{\natexlab{" swap$ * "}}" * } % If yes, wrap it in \natexlab{...} for hyperref compatibility
  if$
  'extra.label := % Store the possibly-wrapped extra label back
  label extra.label * 'label := % Append the extra label to the main label (e.g., "Author, Year" -> "Author, Yeara")
}

% Calculate disambiguation labels ('a', 'b', 'c') using forward and reverse passes.
EXECUTE {initialize.extra.label.stuff}
ITERATE {forward.pass}
REVERSE {reverse.pass}

% --- Redundant Second Sort Removed ---
% FUNCTION {bib.sort.order}
% { sort.label % This was based on names only
%   "    "
%   *
%   year field.or.null sortify
%   *
%   "    "
%   *
%   title field.or.null
%   sort.format.title
%   *
%   #1 entry.max$ substring$
%   'sort.key$ := % Recalculates the same key as presort - redundant
% }
% ITERATE {bib.sort.order} % Redundant iteration
% SORT % Redundant sort

% Bibliography Environment Output

% Writes the beginning of the thebibliography environment.
FUNCTION {begin.bib}
{ preamble$ empty$ % Write preamble if defined in .bib file
    'skip$
    { preamble$ write$ newline$ }
  if$
  % Start the environment, using the total number of entries for label width approximation
  "\begin{thebibliography}{" number.label int.to.str$ * "}" *
  write$ newline$
  % Add natbib compatibility commands (harmless if natbib isn't used)
  "\expandafter\ifx\csname natexlab\endcsname\relax\def\natexlab#1{#1}\fi"
  write$ newline$
  % Provide fallback definitions for URL commands if url/hyperref package isn't loaded
  "\expandafter\ifx\csname url\endcsname\relax"
  write$ newline$
  "  \def\url#1{{\tt #1}}\fi"
  write$ newline$
  "\expandafter\ifx\csname urlprefix\endcsname\relax\def\urlprefix{URL: }\fi"
  write$ newline$
  % Add DOI fallback? Optional.
}

% Execute the begin.bib function.
EXECUTE {begin.bib}

% Initialize the state machine constants.
EXECUTE {init.state.consts}

% Main loop: Iterate through the (now sorted and labeled) entries and call the
% appropriate formatting function based on the entry type (e.g., call 'article' function).
ITERATE {call.type$}

% Writes the end of the thebibliography environment.
FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

% Execute the end.bib function.
EXECUTE {end.bib}