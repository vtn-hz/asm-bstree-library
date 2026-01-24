# BSTree Library

Librería de **Árbol Binario de Búsqueda (BST)** para el sublenguaje de ensamblador.

## Requisitos

```asm
\\INCLUDE "alloc25.asm"
\\INCLUDE "bstree_library.asm"
```

## Estructura del Nodo

Cada nodo ocupa **12 bytes** en memoria:

| Offset | Campo | Descripción |
|--------|-------|-------------|
| 0 | `val` | Valor entero (4 bytes) |
| 4 | `izq` | Puntero al hijo izquierdo (4 bytes) |
| 8 | `der` | Puntero al hijo derecho (4 bytes) |

---

## Funciones Disponibles

### `bstree_create_node`

Crea un nuevo nodo con el valor especificado.

```asm
PUSH <valor>
CALL bstree_create_node
ADD SP, 4
; EAX = puntero al nodo creado
```

**Retorna:** `EAX` contiene el puntero al nuevo nodo.

---

### `bstree_add`

Inserta un nodo en el árbol manteniendo el orden BST.

```asm
PUSH <*nodo>        ; puntero al nodo a insertar
PUSH <**raiz>       ; doble puntero a la raíz
CALL bstree_add
ADD SP, 8
```

**Ejemplo completo:**
```asm
; Crear raíz
DATA raiz DD null

; Crear e insertar nodo con valor 10
PUSH 10
CALL bstree_create_node
ADD SP, 4

PUSH EAX
PUSH raiz
CALL bstree_add
ADD SP, 8
```

---

### `bstree_find`

Busca un valor en el árbol.

```asm
PUSH <valor>        ; valor a buscar
PUSH <*raiz>        ; puntero a la raíz
CALL bstree_find
ADD SP, 8
; EAX = 1 (encontrado) | 0 (no encontrado)
```

**Retorna:** `EAX` = `1` si el valor existe, `0` si no.

---

### `bstree_preorder`

Recorre e imprime el árbol en **preorden** (Raíz → Izquierda → Derecha).

```asm
PUSH <*raiz>
CALL bstree_preorder
ADD SP, 4
```

---

### `bstree_inorder`

Recorre e imprime el árbol en **inorden** (Izquierda → Raíz → Derecha).

```asm
PUSH <*raiz>
CALL bstree_inorder
ADD SP, 4
```

> **Nota:** Imprime los valores en orden ascendente.

---

### `bstree_postorder`

Recorre e imprime el árbol en **postorden** (Izquierda → Derecha → Raíz).

```asm
PUSH <*raiz>
CALL bstree_postorder
ADD SP, 4
```

---

### `bstree_niv`

Calcula la altura del árbol.

```asm
PUSH <*raiz>
CALL bstree_niv
ADD SP, 4
; EAX = altura del árbol
```

**Retorna:** `EAX` contiene la altura (0 si está vacío).

---

## Resumen de Funciones

| Función | Parámetros | Retorno |
|---------|------------|---------|
| `bstree_create_node` | valor | `EAX` = *nodo |
| `bstree_add` | **raíz, *nodo | - |
| `bstree_find` | *raíz, valor | `EAX` = 0/1 |
| `bstree_preorder` | *raíz | imprime |
| `bstree_inorder` | *raíz | imprime |
| `bstree_postorder` | *raíz | imprime |
| `bstree_niv` | *raíz | `EAX` = altura |
