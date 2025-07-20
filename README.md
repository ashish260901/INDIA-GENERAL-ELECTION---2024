# INDIA-GENERAL-ELECTION-RESULTS---2024


NEW COLUMN 
Party Alliance = 
IF(
    partywise_results[Party] = "Bharatiya Janata Party - BJP" ||
    partywise_results[Party] = "Telugu Desam - TDP" ||
    partywise_results[Party] = "Janata Dal  (United) - JD(U)" ||
    partywise_results[Party] = "Shiv Sena - SHS" ||
    partywise_results[Party] = "AJSU Party - AJSUP" ||
   partywise_results[Party] = "Apna Dal (Soneylal) - ADAL" ||
    partywise_results[Party] = "Asom Gana Parishad - AGP" ||
    partywise_results[Party] = "Hindustani Awam Morcha (Secular) - HAMS" ||
    partywise_results[Party] = "Janasena Party - JnP" ||
    partywise_results[Party] = "Janata Dal  (Secular) - JD(S)" ||
    partywise_results[Party] = "Lok Janshakti Party(Ram Vilas) - LJPRV" ||
    partywise_results[Party] = "Nationalist Congress Party - NCP" ||
    partywise_results[Party]= "Rashtriya Lok Dal - RLD" ||
    partywise_results[Party] = "Sikkim Krantikari Morcha - SKM",
    "NDA",
    IF(
        partywise_results[Party] = "Indian National Congress - INC" ||
        partywise_results[Party] = "Aam Aadmi Party - AAAP" ||
        partywise_results[Party] = "All India Trinamool Congress - AITC" ||
        partywise_results[Party] = "Bharat Adivasi Party - BHRTADVSIP" ||
        partywise_results[Party]= "Communist Party of India  (Marxist) - CPI(M)" ||
        partywise_results[Party] = "Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)" ||
        partywise_results[Party] = "Communist Party of India - CPI" ||
        partywise_results[Party] = "Dravida Munnetra Kazhagam - DMK" ||
        partywise_results[Party] = "Indian Union Muslim League - IUML" ||
        partywise_results[Party] = "Jammu & Kashmir National Conference - JKN" ||
        partywise_results[Party] = "Jharkhand Mukti Morcha - JMM" ||
        partywise_results[Party] = "Kerala Congress - KEC" ||
        partywise_results[Party] = "Marumalarchi Dravida Munnetra Kazhagam - MDMK" ||
        partywise_results[Party] = "Nationalist Congress Party Sharadchandra Pawar - NCPSP" ||
        partywise_results[Party] = "Rashtriya Janata Dal - RJD" ||
        partywise_results[Party] = "Rashtriya Loktantrik Party - RLTP" ||
        partywise_results[Party] = "Revolutionary Socialist Party - RSP" ||
        partywise_results[Party] = "Samajwadi Party - SP" ||
        partywise_results[Party] = "Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT" ||
        partywise_results[Party] = "Viduthalai Chiruthaigal Katchi - VCK",
        "I.N.D.I.A.",
        "OTHER"
    )
)


NEW MEASURE
Total Seats = SUM(partywise_results[Won])


NEW MEASURE
NDA Seats = CALCULATE([Total Seats], partywise_results[Party Alliance] = "NDA")


NEW MEASURE
% of NDA Seats = DIVIDE([NDA Seats], [Total Seats], 0)


NEW MEASURE
INDIA Seats = CALCULATE([Total Seats], partywise_results[Party Alliance] = “I.N.D.I.A.”)


NEW MEASURE
% of INDIA Seats = DIVIDE([INDIA Seats], [Total Seats], 0)


NEW MEASURE
Other Seats = CALCULATE([Total Seats], partywise_results[Party Alliance] = "OTHER")


NEW MEASURE
% of Other Seats = DIVIDE([Other Seats], [Total Seats], 0)


NEW MEASURE
NDA Seats Count = CALCULATE(COUNT(constituencywise_results[Constituency Name]),
           partywise_results[Party Alliance] = "NDA")


NEW MEASURE
INDIA Seats Count = CALCULATE(COUNT(constituencywise_results[Constituency Name]),
           partywise_results[Party Alliance] = “I”.N.D.I.A.)


NEW MEASURE
OTHER Seats Count = CALCULATE(COUNT(constituencywise_results[Constituency Name]),
           partywise_results[Party Alliance] = "OTHER")


NEW MEASURE
Winning Alliance = 

VAR NDASeats = CALCULATE(COUNT(constituencywise_results[Constituency Name]), partywise_results[Party Alliance] = "NDA")

VAR INDIASeats = CALCULATE(COUNT(constituencywise_results[Constituency Name]), partywise_results[Party Alliance] = "I.N.D.I.A.")

RETURN
IF(NDASeats >= INDIASeats, "NDA", "I.N.D.I.A.")


NEW COLUMN
Party Name (Result) = LOOKUPVALUE(partywise_results[Party], partywise_results[Party ID], constituencywise_results[Party ID])


NEW COLUMN
Party Alliance (Result) = LOOKUPVALUE(partywise_results[Party Alliance], partywise_results[Party ID], constituencywise_results[Party ID])


NEW COLUMN
Winning Alliance Legend = 

VAR NDASeats = CALCULATE(COUNT(constituencywise_results[Constituency Name]), partywise_results[Party Alliance] = "NDA")

VAR INDIASeats = CALCULATE(COUNT(constituencywise_results[Constituency Name]), partywise_results[Party Alliance] = "I.N.D.I.A.")

RETURN
IF(NDASeats >= INDIASeats, "NDA", "I.N.D.I.A.")

NEW COLUMN
Party Short Name = LOOKUPVALUE(partywise_results[Party Short], partywise_results[Party ID], constituencywise_results[Party ID])


NEW MEASURE
State Secondary KPI = 

 CALCULATE(SELECTEDVALUE(states[State], "No State"),
            FILTER(constituencywise_results,constituencywise_results[Constituency ID] = MAX
            (constituencywise_details[Constituency Number])
            )
)


NEW MEASURE
Total Votes KPI = "Total Votes" & ": " & MAX(constituencywise_details[Total Votes])


NEW MEASURE
Vote Share KPI = "Vote Share:" & " " & MAX(constituencywise_details[% of Votes]) &  " %”


NEW MEASURE
Runner Up Candidate = 

VAR MaxVotes = MAX(constituencywise_details[Total Votes])

VAR SecondMaxVotes = 
    MAXX(
        FILTER(constituencywise_details,constituencywise_details[Total Votes] < MaxVotes),
        constituencywise_details[Total Votes]
    )
RETURN
    CALCULATE(
        MAX(constituencywise_details[Candidate]),
        constituencywise_details[Total Votes] = SecondMaxVotes
    )


NEW MEASURE
Runner Up Party = 

VAR MaxVotes = MAX(constituencywise_details[Total Votes])

VAR SecondMaxVotes = 
    MAXX(
        FILTER(constituencywise_details,constituencywise_details[Total Votes] < MaxVotes),
        constituencywise_details[Total Votes]
    )
RETURN
    CALCULATE(
        MAX(constituencywise_details[Party]),
        constituencywise_details[Total Votes] = SecondMaxVotes
    )


NEW MEASURE
Runner Up Votes = 
"Total Votes: " &
VAR MaxVotes = MAX(constituencywise_details[Total Votes])

VAR SecondMaxVotes = 
    MAXX(
        FILTER(constituencywise_details,constituencywise_details[Total Votes] < MaxVotes),
        constituencywise_details[Total Votes]
    )
RETURN
    SecondMaxVotes


NEW MEASURE
Runner Up % of Votes = 
"Vote Share: " &
VAR MaxVotes = MAX(constituencywise_details[% of Votes])

VAR SecondMaxVotes = 
    MAXX(
        FILTER(constituencywise_details,constituencywise_details[% of Votes] < MaxVotes),
        constituencywise_details[% of Votes]
    )
RETURN
    SecondMaxVotes & " %"


NEW MEASURE
Second Runner Up Candidate = 

VAR MaxVotes = MAX(constituencywise_details[Total Votes])

VAR SecondMaxVotes = 
    MAXX(
        FILTER(constituencywise_details,constituencywise_details[Total Votes] < MaxVotes),
        constituencywise_details[Total Votes]
    )

VAR ThirdMaxVotes = 
    MAXX(
        FILTER(constituencywise_details,constituencywise_details[Total Votes] < SecondMaxVotes),
        constituencywise_details[Total Votes]
    )
RETURN
    CALCULATE(
        MAX(constituencywise_details[Candidate]),
        constituencywise_details[Total Votes] = ThirdMaxVotes
    )


NEW MEASURE
Second Runner Up Party = 

VAR MaxVotes = MAX(constituencywise_details[Total Votes])

VAR SecondMaxVotes = 
    MAXX(
        FILTER(constituencywise_details,constituencywise_details[Total Votes] < MaxVotes),
        constituencywise_details[Total Votes]
    )

VAR ThirdMaxVotes = 
    MAXX(
        FILTER(constituencywise_details,constituencywise_details[Total Votes] < SecondMaxVotes),
        constituencywise_details[Total Votes]
    )
RETURN
    CALCULATE(
        MAX(constituencywise_details[Party]),
        constituencywise_details[Total Votes] = ThirdMaxVotes


NEW MEASURE
Second Runner Up Total Votes = 
"Total Votes: " &
VAR MaxVotes = MAX(constituencywise_details[Total Votes])

VAR SecondMaxVotes = 
    MAXX(
        FILTER(constituencywise_details,constituencywise_details[Total Votes] < MaxVotes),
        constituencywise_details[Total Votes]
    )

VAR ThirdMaxVotes = 
    MAXX(
        FILTER(constituencywise_details,constituencywise_details[Total Votes] < SecondMaxVotes),
        constituencywise_details[Total Votes]
    )
RETURN
    ThirdMaxVotes


NEW MEASURE
Second Runner Up % of Votes = 
"Vote Share: " &
VAR MaxVotes = MAX(constituencywise_details[% of Votes])

VAR SecondMaxVotes = 
    MAXX(
        FILTER(constituencywise_details,constituencywise_details[% of Votes] < MaxVotes),
        constituencywise_details[% of Votes]
    )

VAR ThirdMaxVotes = 
    MAXX(
        FILTER(constituencywise_details,constituencywise_details[% of Votes] < SecondMaxVotes),
        constituencywise_details[% of Votes]
    )
RETURN
    ThirdMaxVotes & " %"
