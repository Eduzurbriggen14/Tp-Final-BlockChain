// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../lib/forge-std/src/Test.sol";
import "../src/BUSD.sol";
import "../src/CCNFT.sol";

// Definición del contrato de prueba CCNFTTest que hereda de Test. 
// Declaración de direcciones y dos instancias de contratos (BUSD y CCNFT).
contract CCNFTTest is Test {
    address deployer;
    address c1;
    address c2;
    address funds;
    address fees;
    BUSD busd;
    CCNFT ccnft;

// Ejecución antes de cada prueba. 
// Inicializar las direcciones y desplgar las instancias de BUSD y CCNFT.
    function setUp() public {
        deployer = makeAddr("deployer");
        c1 = makeAddr("c1");
        c2= makeAddr("c2");
        funds = makeAddr("funds");
        fees = makeAddr("fees");
        busd = new BUSD();
        ccnft = new CCNFT("token", "tk");
    }

// Prueba de "setFundsCollector" del contrato CCNFT. 
// Llamar al método y despues verificar que el valor se haya establecido correctamente.
    function testSetFundsCollector() public {
        assertEq(ccnft.fundsCollector(), address(0), "Valor de direccion erroneo");
        ccnft.setFundsCollector(funds);
        assertEq(ccnft.fundsCollector(), funds, "Direccion erronea, no coincide con la direccion de fundsCollector");
    }

// Prueba de "setFeesCollector" del contrato CCNFT
// Verificar que el valor se haya establecido correctamente.
    function testSetFeesCollector() public {
        assertEq(ccnft.feesCollector(), address(0), "la direccion de feesCollector es erronea");
        ccnft.setFeesCollector(fees);
        assertEq(ccnft.feesCollector(), fees, "Direccion erronea, no coincide con la direccion de feesCollector");
    }

// Prueba de "setProfitToPay" del contrato CCNFT
// Verificar que el valor se haya establecido correctamente.
    function testSetProfitToPay() public {
        assertEq(ccnft.profitToPay(), 0, "Valor incorrecto de profitToPay");
        ccnft.setProfitToPay(100);
        assertEq(ccnft.profitToPay(), 100, "Valor incorrecto, difiere del profitToPay");

        
    }

// Prueba de "setCanBuy" primero estableciéndolo en true y verificando que se establezca correctamente.
// Despues establecerlo en false verificando nuevamente.
    function testSetCanBuy() public {
        assertEq(ccnft.canBuy(), false, "Valor de canBuy erroneo");
        ccnft.setCanBuy(true);
        assertEq(ccnft.canBuy(), true, "Valor de canBuy erroneo, difiere del asignado");
        ccnft.setCanBuy(false);
        assertEq(ccnft.canBuy(), false, "Valor de canBuy erroneo, difiere del asignado");
    }

// Prueba de método "setCanTrade". Similar a "testSetCanBuy".
    function testSetCanTrade() public {
        assertEq(ccnft.canTrade(), false, unicode"El valor de canTrade tiene un valor inicial incorrecto");
        ccnft.setCanTrade(true);
        assertEq(ccnft.canTrade(), true, unicode"El valor de canTrade difiere del valor asignado");
        ccnft.setCanTrade(false);
        assertEq(ccnft.canTrade(), false, unicode"El valor de canTrade difiere del valor asignado");
    }

// Prueba de método "setCanClaim". Similar a "testSetCanBuy".
    function testSetCanClaim() public {
         assertEq(ccnft.canClaim(), false, unicode"El valor de canClaim tiene un valor inicial incorrecto");
        ccnft.setCanClaim(true);
        assertEq(ccnft.canClaim(), true, unicode"El valor de canClaim difiere del valor asignado");
        ccnft.setCanClaim(false);
        assertEq(ccnft.canClaim(), false, unicode"El valor de canClaim difiere del valor asignado");
    }

// Prueba de "setMaxValueToRaise" con diferentes valores.
// Verifica que se establezcan correctamente.
    function testSetMaxValueToRaise() public {
        assertEq(ccnft.maxValueToRaise(), 0, unicode"El valor de maxValueToRaise tiene un valor inicial incorrecto");
        ccnft.setMaxValueToRaise(100);
        assertEq(ccnft.maxValueToRaise(), 100, unicode"El valor de maxValueToRaise difiere del valor asignado");
    }

// Prueba de "addValidValues" añadiendo diferentes valores.
// Verificar que se hayan añadido correctamente.
    function testAddValidValues() public {
        ccnft.addValidValues(4);
        ccnft.addValidValues(1);
        ccnft.addValidValues(5);
        ccnft.addValidValues(2);
        ccnft.addValidValues(3);
        assertEq(ccnft.validValues(1), true, unicode"El valor añadido 1 no se encuentra habilitado");
        assertEq(ccnft.validValues(4), true, unicode"El valor añadido 4 no se encuentra habilitado");
        assertEq(ccnft.validValues(6), false, unicode"El valor 6 no debería estar habilitado");
    }

// Prueba de "deleteValidValues" añadiendo y luego eliminando un valor.
// Verificar que la eliminación se haya realizado correctamente.
    function testDeleteValidValues() public {
        ccnft.addValidValues(50);
        ccnft.deleteValidValues(50);
        assertEq(ccnft.validValues(50), false, unicode"El valor eliminado sigue habilitado");
    }

// Prueba de "setMaxBatchCount".
// Verifica que el valor se haya establecido correctamente.
    function testSetMaxBatchCount() public {
        assertEq(ccnft.maxBatchCount(), 0, unicode"El valor de maxBatchCount tiene un valor inicial incorrecto");
        ccnft.setMaxBatchCount(100);
        assertEq(ccnft.maxBatchCount(), 100, unicode"El valor de maxBatchCount difiere del valor asignado");
    }

// Prueba de "setBuyFee".
// Verificar que el valor se haya establecido correctamente.
    function testSetBuyFee() public {
        assertEq(ccnft.buyFee(), 0, unicode"El valor de buyFee tiene un valor inicial incorrecto");
        ccnft.setBuyFee(100);
        assertEq(ccnft.buyFee(), 100, unicode"El valor de buyFee difiere del valor asignado");
    }

// Prueba de "setTradeFee".
// Verificar que el valor se haya establecido correctamente.
    function testSetTradeFee() public {
        assertEq(ccnft.tradeFee(), 0, unicode"El valor de tradeFee tiene un valor inicial incorrecto");
        ccnft.setTradeFee(100);
        assertEq(ccnft.tradeFee(), 100, unicode"El valor de tradeFee difiere del valor asignado");

    }

// Prueba de que no se pueda comerciar cuando canTrade es false.
// Verificar que se lance un error esperado.
    function testCannotTradeWhenCanTradeIsFalse() public {
        ccnft.setCanTrade(false);
        vm.expectRevert();
        ccnft.trade(1);
    }

// Prueba que no se pueda comerciar con un token que no existe, incluso si canTrade es true. 
// Verificar que se lance un error esperado.
    function testCannotTradeWhenTokenDoesNotExist() public {
        ccnft.setCanTrade(true);
        vm.expectRevert();
        ccnft.trade(1);
    }
}
