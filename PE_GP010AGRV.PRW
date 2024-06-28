/*/{Protheus.doc} GP010AGRV
	Ponto de Entrada para gravar informações do funcionário 
	@type function
	@version 1.0
/*/
User Function GP010AGRV()

	oIntOkta := TOktaIntegration():New()

	cResult := oIntOkta:GetIdOktaTotvs(SRA->RA_MAT)

	If ( INCLUI .AND. !Empty(SRA->RA_EMAIL) )

		oIntOkta:CreateUserWithGroup()

	EndIf
	If ( ALTERA )

		If ( cResult[3] != RA_CODFUNC )

			If ( !Empty(SRA->RA_EMAIL) )
				
				oResponse := oIntOkta:GetUserId(SRA->RA_EMAIL)

				If ( Empty(oResponse["id"]) .AND. Empty(SRA->RA_HIERARQ))

					oIntOkta:CreateUserWithGroup()

				ElseiF ( !Empty(oResponse["id"]) .AND. Empty(SRA->RA_HIERARQ) )
				
					oIntOkta:UpUserGrp(SRA->RA_EMAIL, SRA->RA_CODFUNC, SRA->RA_MAT)

				//If ( !Empty(SRA->RA_DEMISSA .AND SA->RA_MSBLQL) )
				ElseiF ( !Empty(SRA->RA_HIERARQ))

					oIntOkta:DeactivateUser(SRA->RA_EMAIL, SRA->RA_MAT)
				
				EndIf
			Else
		
		 		Alert("Email não preenchido, Não Foi integrado com o OKTA!")
					
			EndIf
		EndIf
	EndIf

Return .T.

