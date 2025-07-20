SELECT * FROM India_Election_Results.constituencywise_details;
SELECT * FROM India_Election_Results.constituencywise_results;
SELECT * FROM India_Election_Results.partywise_results;
SELECT * FROM India_Election_Results.states;
SELECT * FROM India_Election_Results.statewise_results;

-- Total Seats
SELECT 
    COUNT(DISTINCT `Parliament Constituency`) AS Total_Seats
FROM
    India_Election_Results.constituencywise_results;
    
-- What are the total number of seats available for elections in each state
SELECT 
    s.state AS State_Name, 
    COUNT(cr.`Parliament Constituency`) AS Total_Seats 
FROM 
    constituencywise_results cr 
INNER JOIN 
    statewise_results sr 
    ON cr.`Parliament Constituency` = sr.`Parliament Constituency` 
INNER JOIN 
    states s 
    ON sr.`State ID` = s.`State ID` 
GROUP BY 
    s.state;
    
-- Total Seats Won by NDA Alliance
SELECT 
    SUM(CASE 
            WHEN party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP',
                'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS',
                'AJSU Party - AJSUP',
                'Apna Dal (Soneylal) - ADAL',
                'Asom Gana Parishad - AGP', 
                'Hindustani Awam Morcha (Secular) - HAMS',
                'Janasena Party - JnP',
                'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD',
                'Sikkim Krantikari Morcha - SKM'
            ) 
            THEN `Won` 
            ELSE 0 
        END
    ) AS NDA_Total_Seats_Won 
FROM 
    partywise_results;
    
-- Seats Won by NDA Alliance Parties
SELECT 
    party AS Party_Name, won AS Seats_Won
FROM
    partywise_results
WHERE
    party IN ('Bharatiya Janata Party - BJP' , 'Telugu Desam - TDP',
        'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS',
        'AJSU Party - AJSUP',
        'Apna Dal (Soneylal) - ADAL',
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS',
        'Janasena Party - JnP',
        'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV',
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD',
        'Sikkim Krantikari Morcha - SKM')
ORDER BY Seats_Won DESC;

-- Total Seats Won by I.N.D.I.A. Alliance
SELECT 
    SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC', 
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) 
            THEN `Won` 
            ELSE 0 
        END
    ) AS INDIA_Total_Seats_Won 
FROM 
    partywise_results;
    
-- Seats Won by I.N.D.I.A. Alliance Parties
SELECT 
    party, won
FROM
    partywise_results
WHERE
    party IN ('Indian National Congress - INC' , 'Aam Aadmi Party - AAAP',
        'All India Trinamool Congress - AITC',
        'Bharat Adivasi Party - BHRTADVSIP',
        'Communist Party of India  (Marxist) - CPI(M)',
        'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
        'Communist Party of India - CPI',
        'Dravida Munnetra Kazhagam - DMK',
        'Indian Union Muslim League - IUML',
        'Jharkhand Mukti Morcha - JMM',
        'Jammu & Kashmir National Conference - JKN',
        'Kerala Congress - KEC',
        'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
        'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
        'Rashtriya Janata Dal - RJD',
        'Rashtriya Loktantrik Party - RLTP',
        'Revolutionary Socialist Party - RSP',
        'Samajwadi Party - SP',
        'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
        'Viduthalai Chiruthaigal Katchi - VCK')
ORDER BY won DESC;

-- Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER
ALTER TABLE partywise_results ADD party_alliance VARCHAR(50);
SELECT * FROM partywise_results;

UPDATE partywise_results 
SET 
    party_alliance = 'I.N.D.I.A.'
WHERE
    party IN ('Indian National Congress - INC' , 'Aam Aadmi Party - AAAP',
        'All India Trinamool Congress - AITC',
        'Bharat Adivasi Party - BHRTADVSIP',
        'Communist Party of India  (Marxist) - CPI(M)',
        'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
        'Communist Party of India - CPI',
        'Dravida Munnetra Kazhagam - DMK',
        'Indian Union Muslim League - IUML',
        'Jharkhand Mukti Morcha - JMM',
        'Jammu & Kashmir National Conference - JKN',
        'Kerala Congress - KEC',
        'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
        'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
        'Rashtriya Janata Dal - RJD',
        'Rashtriya Loktantrik Party - RLTP',
        'Revolutionary Socialist Party - RSP',
        'Samajwadi Party - SP',
        'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
        'Viduthalai Chiruthaigal Katchi - VCK');
        
UPDATE partywise_results 
SET 
    party_alliance = 'NDA'
WHERE
    party IN ('Bharatiya Janata Party - BJP' , 'Telugu Desam - TDP',
        'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS',
        'AJSU Party - AJSUP',
        'Apna Dal (Soneylal) - ADAL',
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS',
        'Janasena Party - JnP',
        'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV',
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD',
        'Sikkim Krantikari Morcha - SKM');
-------------------------------------------------------------------------------        
UPDATE partywise_results 
SET 
    party_alliance = 'OTHER'
WHERE
    party_alliance IS NULL;    
-------------------------------------------------------------------------------    
SELECT * FROM partywise_results;
-------------------------------------------------------------------------------
SELECT 
    party_alliance, SUM(won)
FROM
    partywise_results
GROUP BY party_alliance;
-------------------------------------------------------------------------------
SELECT 
    party, won
FROM
    partywise_results
WHERE
    party_alliance = 'I.N.D.I.A.'
ORDER BY won DESC;

-- Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?
SELECT
    alliance,
    SUM(`WON`) AS Seats_Won
FROM (
    SELECT 
        Party,
        `WON`,
        CASE 
            WHEN Party IN (
                'Bharatiya Janta Party - BJP', 
                'Telugu Desam - TDP', 
                'Janata Dal (United) - JD(U)', 
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP', 
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - Jnp', 
                'Janata Dal (Secular) - JD(S)', 
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP', 
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
            ) THEN 'NDA'
            
            WHEN Party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAP',
                'Samajwadi Party - SP',
                'DMK - DMK',
                'Trinamool Congress - AITC',
                'Shiv Sena (UBT) - SS(UBT)',
                'Nationalist Congress Party (Sharadchandra Pawar) - NCP(SP)',
                'Communist Party of India (Marxist) - CPI(M)',
                'Rashtriya Janata Dal - RJD',
                'Jharkhand Mukti Morcha - JMM',
                'IUML - IUML'
            ) THEN 'I.N.D.I.A'
            
            ELSE 'OTHER'
        END AS alliance
    FROM 
        partywise_results
) AS sub
GROUP BY 
    alliance
ORDER BY 
    Seats_Won DESC
LIMIT 1;

-- Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?
SELECT 
    cr.`Winning Candidate`,
    pr.`Party`,
    pr.party_alliance,
    cr.`Total Votes`,
    cr.`Margin`,
    cr.`Constituency Name`,
    s.`State`
FROM
    constituencywise_results cr
        INNER JOIN
    partywise_results pr ON cr.`Party ID` = pr.`Party ID`
        INNER JOIN
    statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
        INNER JOIN
    states s ON sr.`State ID` = s.`State ID`
WHERE
    cr.`Constituency Name` = 'DHANBAD';

-- What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
SELECT 
    cd.`Candidate`,
    cr.`Constituency Name`,
    cd.`EVM VOTES`,
    cd.`Postal Votes`,
    cd.`Total Votes`
FROM
    constituencywise_results cr
        JOIN
    constituencywise_details cd ON cr.`Constituency ID` = cd.`Constituency ID`
WHERE
    cr.`Constituency Name` = 'AMETHI';
    
-- Which parties won the most seats in s State, and how many seats did each party win?
SELECT 
    p.`Party`, COUNT(cr.`Constituency ID`) AS Seats_Won
FROM
    constituencywise_results cr
        JOIN
    partywise_results p ON cr.`Party ID` = p.`Party ID`
        JOIN
    statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
        JOIN
    states s ON sr.`State ID` = s.`State ID`
WHERE
    s.`State` = 'Jharkhand'
GROUP BY p.`Party`
ORDER BY Seats_Won DESC;

-- What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024
SELECT 
    s.`State`,
    SUM(CASE
        WHEN p.party_alliance = 'NDA' THEN 1
        ELSE 0
    END) AS NDA_Seats_Won,
    SUM(CASE
        WHEN p.party_alliance = 'I.N.D.I.A.' THEN 1
        ELSE 0
    END) AS INDIA_Seats_Won,
    SUM(CASE
        WHEN p.party_alliance = 'OTHER' THEN 1
        ELSE 0
    END) AS OTHER_Seats_Won
FROM
    constituencywise_results cr
        JOIN
    partywise_results p ON cr.`Party ID` = p.`Party ID`
        JOIN
    statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
        JOIN
    states s ON sr.`State ID` = s.`State ID`
WHERE
    s.`State` = 'Jharkhand'
GROUP BY s.`State`;

-- Which candidate received the highest number of EVM votes in each constituency (Top 10)?
SELECT 
    cr.`Constituency Name`,
    cd.`Constituency ID`,
    cd.`Candidate`,
    cd.`EVM Votes`
FROM
    constituencywise_details cd
        JOIN
    constituencywise_results cr ON cd.`Constituency ID` = cr.`Constituency ID`
WHERE
    cd.`EVM Votes` = (SELECT 
            MAX(cd1.`EVM Votes`)
        FROM
            constituencywise_details cd1
        WHERE
            cd1.`Constituency ID` = cd.`Constituency ID`)
ORDER BY cd.`EVM Votes` DESC
LIMIT 10;

-- Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?
WITH RankedCandidates AS (
    SELECT 
        cd.`Constituency ID`, 
        cd.`Candidate`, 
        cd.`Party`, 
        cd.`EVM Votes`, 
        cd.`Postal Votes`, 
        cd.`EVM Votes` + cd.`Postal Votes` AS Total_Votes,
        ROW_NUMBER() OVER (
            PARTITION BY cd.`Constituency ID` 
            ORDER BY cd.`EVM Votes` + cd.`Postal Votes` DESC
        ) AS VoteRank
    FROM 
        constituencywise_details cd
    JOIN 
        constituencywise_results cr ON cd.`Constituency ID` = cr.`Constituency ID`
    JOIN 
        statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
    JOIN 
        states s ON sr.`State ID` = s.`State ID`
    WHERE 
        s.`State` = "Jharkhand"
)

SELECT 
    cr.`Constituency Name`,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.`Candidate` END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.`Candidate` END) AS Runner_Up_Candidate
FROM 
    RankedCandidates rc
JOIN 
    constituencywise_results cr ON rc.`Constituency ID` = cr.`Constituency ID`
GROUP BY 
    cr.`Constituency Name`
ORDER BY 
    cr.`Constituency Name`;

-- For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?
SELECT 
    COUNT(DISTINCT cr.`Constituency ID`) AS Total_Seats,
    COUNT(DISTINCT cd.`Candidate`) AS Total_Candidates,
    COUNT(DISTINCT cd.`Party`) AS Total_Parties,
    SUM(cd.`EVM Votes` + cd.`Postal Votes`) AS Total_Votes,
    SUM(cd.`EVM Votes`) AS Total_EVM_Votes,
    SUM(cd.`Postal Votes`) AS Total_Postal_Votes
FROM
    constituencywise_details cd
        JOIN
    constituencywise_results cr ON cd.`Constituency ID` = cr.`Constituency ID`
        JOIN
    statewise_results sr ON cr.`Parliament Constituency` = sr.`Parliament Constituency`
        JOIN
    states s ON sr.`State ID` = s.`State ID`
WHERE
    s.`State` = 'Maharashtra';









