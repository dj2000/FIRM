call rails g scaffold client firstName:string lastName:string middleInit:string phoneH:string phoneW:string phoneC:string email:string mailAddress:text
call rails g scaffold agent firstName:string lastName:string middleInit:string company:string phoneH:string phoneW:string phoneC:string email:string mailAddress:text
call rails g scaffold property number:integer street:string city:string state:string zip:integer crossStreet:string mapPage:integer yearBuilt:integer size:integer stories:integer type:string units:integer gndUnits:integer lotType:string foundation:string hpoz?:boolean cdo?:boolean
call rails g scaffold client_properties client_id:integer property_id:integer clientType:string typeDate:date occupiedBy:string escrow:boolean escrowDate:date
call rails g scaffold agent_clients agent_id:integer client_id:integer agentDate:date
call rails g scaffold inspRequest callTime:datetime callerType:string referalSource:string client_id:integer agent_id:integer property_id:integer selectInsp:string
call rails g scaffold appointment inspRequest_id:integer schedStart:datetime schedEnd:datetime allDay:boolean inspector_id:integer contact:string inspFee:decimal prepaid:boolean pmtMethod:string pmtRef:string notes:text
call rails g scaffold svcCriteria propRes:boolean propComm:boolean prevInsp:string hpoz:string cdo:string ownerOcc:boolean foundation:string yearBuilt:integer notes:text
call rails g scaffold svcArea zip:integer city:string state:string serviced:boolean
call rails g scaffold inspector firstName:string lastName:string middleInit:string senior:boolean phoneH:string phoneC:string address:string city:string state:string zip:integer email:string
call rails g scaffold inspSkill inspector_id:integer skill_id
call rails g scaffold skill skill:string
call rails g scaffold iFeeSchedule feeActive:boolean effectiveFrom:date ownerOccRate:decimal sfrBaseRate:decimal sfrIncRate:decimal mfrBaseRate:decimal mfrIncRate:decimal insBaseRate:decimal insIncRate:decimal 
call rails g scaffold invoice reference:string type:string inspection_id	project_id description:string invoiceDate:date amount:decimal
call rails g scaffold receipt reference:string date:date invoice_id:integer amount:decimal recBy:string
call rails g scaffold inspection fCondition:string businessCards:boolean nOD:integer nOG:integer paid?:boolean reportURL:string footprintURL:string repairs?:boolean permit?:boolean interiorAccess:boolean verifiedReport:boolean verifiedComp:boolean notes:text
call rails g scaffold bid inspection_id costRepair:decimal feeSeismicUpg:decimal feeAdmin:decimal payPlan_id:integer status:string
call rails g scaffold payPlan jobMinAmt:integer jobMaxAmt:integer pmt1Pcnt:integer pmt2Pcnt:integer pmt3Pcnt:integer	pmt4Pcnt:integer pmt5Pcnt:integer pmt1Desc:integer pmt2Desc:integer pmt3Desc:integer pmt4Desc:integer pmt5Desc:integer
call rails g scaffold commHistory inspection_id:integer caller:string  caller:string recipient:string callSummary:text callOutcome:string callBackDate:datetime  notes:text
call rails g scaffold contracts bid_id:integer payPlan_id:integer date:date signedBy:string acceptedBy:string dateSigned:date downPmtAmt:decimal downPmtDate:date
call rails g scaffold pmtSchedule contract_id:integer pmtNumber:integer pmtDate:date pmtAmount:decimal
call rails g scaffold projects vcDate:date contract_id:integer jobCost:decimal  scheduleBy:date schedulePref:string estDuration:integer scheduleStart:date scheduleEnd:date authorizedBy:string authorizedOn:date crew_id:integer verifiedAccess:boolean verifiedEW:boolean notes:text
call rails g scaffold projSched project_id:integer crew_id:integer date:date startTime:time endTime:time	notes:text
call rails g scaffold crew foreman:string size:integer doubleBook?:boolean notes:text
call rails g scaffold crewSkill crew_id:integer skill_id
call rails g scaffold permit reference:string project_id:integer issueDate:date issuedBy:string status:string valuation:decimal
call rails g scaffold projInsp project_id:integer reference:string scheduleDate:date inspectBy:string completeDate:date result:string 
call rails g scaffold commission year:integer weekNo:Integer rate:decimal

